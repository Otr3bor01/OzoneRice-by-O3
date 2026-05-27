----------------
----programs----
----------------
local terminal = "kitty"
local fileManager_TUI = "lf"
local menu = "fuzzel" --wip
-- local textEditor = nvim
-- local codeTextEditor = vscodium
local fileManager_GUI = "thunar"
local mainMod = "SUPER"
-- local musicPlayer =
local browser = "firefox"

-------------
----binds----
-------------
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))    --terminal
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))  --hyprlock
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(terminal .. " -e " .. fileManager_TUI))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(fileManager_GUI))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
--hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(musicPlayer))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian")) --obsidian
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("code")) --vscode
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("ao"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("vesktop"))

--window_binds / workspace_binds--
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + C", hl.dsp.window.close())        --Close window
hl.bind(mainMod .. " + left", hl.dsp.focus({direction = "left"}))
hl.bind(mainMod .. " + right", hl.dsp.focus({direction = "right"}))
hl.bind(mainMod .. " + up", hl.dsp.focus({direction = "up"}))
hl.bind(mainMod .. " + down", hl.dsp.focus({direction = "down"}))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))


for i = 1, 5 do
    local key = tostring(i)
    hl.bind(mainMod .. " + " .. key, function()
        local ws = hl.get_active_workspace()
        if ws == nil then return end
        
        if ws.id == i then
            hl.dispatch(hl.dsp.focus({ workspace = i + 5 }))
        else
            hl.dispatch(hl.dsp.focus({ workspace = i }))
        end
    end)
end

for i = 1, 5 do
    local key = tostring(i)
    hl.bind(mainMod .. " + SHIFT + " .. key, function()
        local ws = hl.get_active_workspace()
        if ws == nil then return end
        
        if ws.id == i then
            hl.dispatch(hl.dsp.window.move({ workspace = i + 5 }))
        else
            hl.dispatch(hl.dsp.window.move({ workspace = i }))
        end
    end)
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


--system_binds--
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprshutdown --dry-run")) --WIP
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot --freeze -m region"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind(mainMod .. " + F3",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind(mainMod .. " + F1",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })