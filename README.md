# KeyForge Plugins

Official plugin pack for [KeyForge](https://github.com/yoro1836/keyforge).

## Install

1. Open KeyForge WebUI in AX Manager
2. Click **+ Add** and select a `.lua` file
3. Configure settings per plugin
4. Click **Save**

Or manually: copy `.lua` files to `/sdcard/.keyforge/plugins/`, then click ↻ in WebUI.

## Plugins

| File | Description | Settings |
|------|-------------|----------|
| `deadzone.lua` | Circular inner deadzone — zeros small stick movements | Left/Right (‰) |
| `square.lua` | Circular→square stick mapping per stick | Left/Right toggle |
| `outer_deadzone.lua` | Edge saturation — small pushes reach full output | Left/Right (‰) |
| `trigger_curve.lua` | Trigger sensitivity curve + output range per side | Min/Max/Curve |
| `button_remap.lua` | Remap up to 4 button pairs (source → target) | Src/Dst pairs |

## Plugin Structure

```lua
return {
  id = "my_plugin",
  name = "My Plugin",
  version = "1.0.0",
  author = "you",
  description = "What it does",
  settings = {
    { key = "my_toggle", label = "Enable", kind = "toggle", default = "1" },
    { key = "my_value",  label = "Value",  kind = "permille", default = "500", min = 0, max = 1000 },
  },
  process = function(ev, cfg, pf)
    -- modify ev, call pf.emit() / pf.drop(), return ev
    return ev
  end
}
```

### Event fields

| `ev.kind` | Fields | 
|-----------|--------|
| `"stick"` | `x, y, side` (`"left"`/`"right"`) |
| `"trigger"` | `value, side` |
| `"button"` | `code, pressed` |

### pf API

| Call | Effect |
|------|--------|
| `pf.emit(type, code, value [, hold_ms])` | Emit an input event (EV_KEY=1, EV_ABS=3) |
| `pf.drop()` | Suppress the original event |
| `pf.log(msg)` | Write to daemon log |

### Settings kinds

| Kind | UI | Default range |
|------|----|---------------|
| `"toggle"` | Toggle switch | `"0"` / `"1"` |
| `"permille"` | Slider + number input | 0–1000 (‰) |
| `"number"` | Number input | Any |

Device selection is handled in the WebUI — plugins no longer need `init()` functions.
