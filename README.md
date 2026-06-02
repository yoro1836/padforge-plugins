# KeyForge Plugins

Official plugin pack for [KeyForge](https://github.com/yoro1836/keyforge).

## Install

Use the KeyForge app → Install tab to add `.lua` files.

## Plugins

| File | Description |
|------|-------------|
| `deadzone.lua` | Circular deadzone (inner) — zeros small stick movements |
| `square.lua` | Circular→square stick mapping per stick |
| `outer_deadzone.lua` | Edge saturation — small pushes reach full output |
| `trigger_curve.lua` | Trigger sensitivity + range per side |
| `button_remap.lua` | Remap up to 4 button pairs |

## Plugin API

Each plugin defines a `process(ev, cfg, pf)` function. See the [API docs](https://github.com/yoro1836/keyforge/blob/main/docs/PLUGINS.md).
