return {
  "nickjvandyke/opencode.nvim",
  event = "VeryLazy",
  init = function ()
    -- Centered 90% float.
    local function float_opts()
      local w = math.floor(vim.o.columns * 0.9)
      local editor_h = vim.o.lines - vim.o.cmdheight
      local h = math.floor(editor_h * 0.9)
      return {
        relative = "editor",
        width = w,
        height = h,
        row = math.floor((editor_h - h) / 2),
        col = math.floor((vim.o.columns - w) / 2),
        border = "rounded"
      }
    end

    local function git_root()
      local out = vim.fn.systemlist("git rev-parse --show-toplevel")
      if vim.v.shell_error == 0 and #out > 0 then
        return out[1]
      end
    end

    -- Scan .claude/skills, .opencode/skills, .agents/skills for SKILL.md
    -- files and generate matching opencode slash-command files so they
    -- appear in the TUI `/` autocomplete without manual per-repo setup.
    -- Files are written to a temp dir and surfaced via OPENCODE_CONFIG_DIR.
    local function generate_skill_commands(root)
      local search = { root .. "/.claude/skills", root .. "/.opencode/skills", root .. "/.agents/skills" }
      local hash = vim.fn.sha256(root):sub(1, 8)
      local cmddir = string.format("/tmp/opencode-skills-%s/commands", hash)
      vim.fn.mkdir(cmddir, "p")
      for _, old in ipairs(vim.fn.glob(cmddir .. "/*.md", false, true)) do
        vim.fn.delete(old)
      end
      for _, dir in ipairs(search) do
        for _, path in ipairs(vim.fn.glob(dir .. "/*/SKILL.md", false, true)) do
          local name = vim.fn.fnamemodify(path, ":h:t")
          local desc = ""
          local in_fold = false
          for _, line in ipairs(vim.fn.readfile(path, "", 20)) do
            if line:match("^description:%s*>") then
              in_fold = true
            elseif line:match("^description:%s*(.+)") then
              desc = line:match("^description:%s*(.+)")
              break
            elseif in_fold and line:match("^%s+(.+)") then
              desc = vim.trim(line)
              break
            elseif in_fold and not line:match("^%s") then
              break
            end
          end
          if #desc > 120 then desc = desc:sub(1, 117) .. "..." end
          local body = string.format(
            "---\ndescription: %s\nagent: build\n---\n\nLoad and execute the `%s` skill. $ARGUMENTS\n",
            desc ~= "" and desc or ("Run the " .. name .. " skill"), name
          )
          vim.fn.writefile(vim.split(body, "\n"), cmddir .. "/" .. name .. ".md")
        end
      end
      return string.format("/tmp/opencode-skills-%s", hash)
    end

    local function opencode_cmd()
      -- .zshrc's EDITOR=nvim takes effect — opencode opens nvim inside
      -- the terminal float (edit inline, :wq, done).
      -- --continue resumes the most recent session for this project.
      local root = git_root()
      local config_dir = root and generate_skill_commands(root) or nil
      local exports = ""
      if config_dir then
        exports = string.format("export OPENCODE_CONFIG_DIR=%s && ", vim.fn.shellescape(config_dir))
      end
      if root then
        return string.format("cd %s && %sopencode --continue --port", vim.fn.shellescape(root), exports)
      end
      return string.format("%sopencode --continue --port", exports)
    end

    vim.g.opencode_opts = {
      events = {
        permissions = { enabled = false }
      },
      server = {
        start = function ()
          require("opencode.terminal").open(opencode_cmd(), float_opts())
        end,
        stop = function ()
          require("opencode.terminal").close()
        end,
        toggle = function ()
          require("opencode.terminal").toggle(opencode_cmd(), float_opts())
        end
      }
    }
  end,
  config = function ()
    local opencode = require("opencode")
    local oc_bufnr

    local function buf_visible()
      return oc_bufnr and vim.api.nvim_buf_is_valid(oc_bufnr) and #vim.fn.win_findbuf(oc_bufnr) > 0
    end

    local function focus_terminal()
      if not oc_bufnr then
        return
      end
      local win = vim.fn.bufwinid(oc_bufnr)
      if win == -1 then
        return
      end
      vim.api.nvim_set_current_win(win)
      vim.cmd("startinsert")
    end

    -- Kick off the SSE subscription so OpencodeEvent:* autocmds fire even
    -- when the user only toggles the terminal (never calling ask/command).
    local sse_requested = false
    local function ensure_sse()
      if sse_requested then
        return
      end
      sse_requested = true
      require("opencode.server.discovery").get():catch(function ()
        sse_requested = false
      end)
    end

    local function ensure_visible()
      if not buf_visible() then
        opencode.toggle()
      end
      focus_terminal()
    end

    local function continue()
      opencode.toggle()
      if buf_visible() then
        focus_terminal()
        ensure_sse()
      end
    end

    local function fresh()
      ensure_visible()
      opencode.command("session.new")
    end

    local function resume()
      ensure_visible()
      require("opencode.ui.select_session").select_session()
    end

    local function restart()
      pcall(function ()
        require("opencode.terminal").close()
      end)
      vim.defer_fn(continue, 50)
    end

    vim.keymap.set("n", "<A-m>", continue, { desc = "Opencode: toggle" })
    vim.keymap.set("n", "<A-S-m>", fresh, { desc = "Opencode: fresh session" })
    vim.keymap.set("n", "<A-r>", restart, { desc = "Opencode: restart (reload config)" })
    vim.keymap.set("n", "<leader>c", resume, { desc = "Opencode: resume picker" })

    -- Capture the opencode terminal buffer and mirror toggles in terminal mode.
    vim.api.nvim_create_autocmd("TermOpen", {
      group = vim.api.nvim_create_augroup("OpencodeIntegration", { clear = true }),
      callback = function (args)
        if not vim.api.nvim_buf_is_valid(args.buf) then
          return
        end
        if not vim.api.nvim_buf_get_name(args.buf):match("opencode") then
          return
        end
        oc_bufnr = args.buf
        vim.api.nvim_create_autocmd("BufWipeout", {
          buffer = args.buf,
          once = true,
          callback = function ()
            oc_bufnr = nil
          end
        })

        -- The plugin's TermRequest redraw hack enters insert then feedkeys
        -- back to the previous window, stealing focus on first open.
        -- Replace it: same redraw trigger (startinsert) but we stay focused.
        for _, ac in ipairs(vim.api.nvim_get_autocmds({ event = "TermRequest", buffer = args.buf })) do
          vim.api.nvim_del_autocmd(ac.id)
        end
        local redraw_id
        redraw_id = vim.api.nvim_create_autocmd("TermRequest", {
          buffer = args.buf,
          callback = function (ev)
            if ev.data.cursor[1] > 1 then
              vim.api.nvim_del_autocmd(redraw_id)
              focus_terminal()
            end
          end
        })

        local function tmap(lhs, fn, desc)
          vim.keymap.set("t", lhs, fn, { buffer = args.buf, noremap = true, silent = true, desc = desc })
        end
        local esc_pending = false
        local function cancel_esc()
          esc_pending = false
        end

        tmap("<Esc>", function ()
          if esc_pending then
            esc_pending = false
            vim.cmd([[call feedkeys("\<C-\>\<C-n>", "n")]])
            return
          end
          esc_pending = true
          vim.defer_fn(function ()
            if not esc_pending then return end
            esc_pending = false
            vim.api.nvim_chan_send(vim.bo[args.buf].channel, "\27")
          end, 200)
        end, "double-Esc: normal mode, single-Esc: interrupt"
        )

        local function with_cancel_esc(fn)
          return function ()
            cancel_esc()
            fn()
          end
        end
        tmap("<A-m>", with_cancel_esc(continue), "Opencode: toggle")
        tmap("<A-S-m>", with_cancel_esc(fresh), "Opencode: fresh session")
        tmap("<A-r>", with_cancel_esc(restart), "Opencode: restart (reload config)")
        tmap("<leader>c", with_cancel_esc(resume), "Opencode: resume picker")
      end
    })

    -- Hide line numbers and signcolumn in the float.
    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = vim.api.nvim_create_augroup("OpencodeTermOpts", { clear = true }),
      callback = function (args)
        if args.buf ~= oc_bufnr then
          return
        end
        local win = vim.fn.bufwinid(args.buf)
        if win == -1 then
          return
        end
        vim.wo[win].number = false
        vim.wo[win].relativenumber = false
        vim.wo[win].signcolumn = "no"
      end
    })

    -- "Needs attention" notification on idle transition.
    local idle_notified = false
    vim.api.nvim_create_autocmd("User", {
      pattern = "OpencodeEvent:*",
      callback = function ()
        local st = require("opencode.status").status
        if st == "idle" and not idle_notified then
          idle_notified = true
          if vim.api.nvim_get_current_buf() ~= oc_bufnr then
            vim.schedule(function ()
              vim.notify("Opencode needs your attention", vim.log.levels.WARN, { title = "Opencode" })
            end)
          end
        elseif st ~= "idle" then
          idle_notified = false
        end
      end
    })
  end
}
