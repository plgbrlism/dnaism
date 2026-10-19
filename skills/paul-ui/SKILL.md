---
name: paul-ui
description: Paul's ui/ux style. Load for any interface work on web, compose, tui, egui or quickshell. Flat, tonal, material 3 expressive, uneven radii, spring motion.
---

# paul-ui

one-line goal: flat material 3 expressive look, depth from color, never from lines.

## core style

| trait | rule |
|---|---|
| surfaces | flat, tonal layers, depth from color not lines |
| borders | none, no outlines, no dividers unless spacing fails |
| shadows | none or barely there |
| color | dynamic, derived from the wallpaper |
| radius | uneven diagonal: tl 4, tr 12, br 4, bl 12 |
| motion | expressive, spring based, short |
| platform | android look, applied to desktop too |

## radius

| css order | value |
|---|---|
| tl tr br bl | 4 12 4 12 |

- same pattern on every card, button and container unless told otherwise
- circles and pills stay fully round

## motion

- springs over fixed-duration easing
- small overshoot, quick settle
- animate size, position and color shifts, skip decorative loops

## per stack

| stack | notes |
|---|---|
| web | css vars for palette, `border-radius: 4px 12px 4px 12px`, `border: none`, tonal backgrounds, no framework unless asked |
| compose | material 3 expressive theme, dynamic color, shape with per-corner values, `spring()` animations |
| tui | color and spacing matter most, keep it simple, padded color blocks over box-drawing lines |
| egui | per-corner rounding nw 4, ne 12, se 4, sw 12, flat fills, no strokes |
| quickshell | qml rectangles with per-corner radius props (qt 6.7+), palette from wallpaper, spring behaviors |

## avoid

- borders, outlines, drop shadows
- uniform radius everywhere
- gradients and decoration with no job
- verbose ui code, keep it token efficient
