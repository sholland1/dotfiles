import json
import os

qutewal_dynamic_loading = False

home = os.getenv('HOME')
daemon_relative = '.config/qutebrowser/qutewald.py'
daemon_absolute = os.path.join(home, daemon_relative)
with open(os.path.join(home,'.bg')) as bgfile:
    bg = bgfile.read().strip()

hue_1  = '{color6}'
hue_2  = '{color4}'
hue_3  = '{color5}'
hue_4  = '{color2}'

hue_5   = '{color1}'
hue_5_2 = '{color9}'

hue_6   = '{color3}'
hue_6_2 = '{color11}'

if bg == 'dark':
    mono_1 = '{color15}'
    mono_2 = '{color7}'
    mono_3 = '#{color15.darken(46)}'
    mono_4 = '{color8}'

    syntax_bg     = '{color0}'
    syntax_gutter = '#{color8.lighten(14)}'
    syntax_cursor = '#{color0.lighten(4)}'

    syntax_accent = '#{color4.darken(15)}'

    vertsplit    = '#{color15.darken(85)}'
    special_grey = '#{color0.lighten(9)}'
    visual_grey  = '#{color0.lighten(11)}'
    pmenu        = '#{color0.lighten(6)}'

    hue_6_3 = '#{color11.lighten(20)}'
    mono_5 = "#{foreground.lighten(30)}"
else:
    mono_1 = '{color7}'
    mono_2 = '{color15}'
    mono_3 = '#{color7.lighten(48)}'
    mono_4 = '{color8}'

    syntax_bg     = '{color0}'
    syntax_gutter = '#{color0.darken(37)}'
    syntax_cursor = '#{color0.darken(4)}'

    syntax_accent = '#{color4.lighten(9)}'
    syntax_accent_2 = '#{color6.darken(1)}'

    vertsplit    = '#{color7.lighten(87)}'
    special_grey = '#{color0.darken(15)}'
    visual_grey  = '#{color0.darken(17)}'
    pmenu        = '#{color0.darken(11)}'

    hue_6_3 = '#{color11.darken(5)}'
    mono_5 = "#{foreground.lighten(4)}"

syntax_fg = mono_1
syntax_fold_bg = mono_3

# Background color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.bg = hue_2

# Bottom border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.bottom = "{background}"

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.top = "{background}"

# Foreground color of completion widget category headers.
# Type: QtColor
c.colors.completion.category.fg = "{background}"

# Background color of the completion widget for even rows.
# Type: QssColor
c.colors.completion.even.bg = syntax_cursor

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = visual_grey

# Text color of the completion widget.
# Type: QtColor
c.colors.completion.fg = "{foreground}"

# Background color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.bg = mono_4

# Bottom border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.bottom = "{background}"

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.item.selected.border.top = "{background}"

# Foreground color of the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.fg = "{background}"

# Foreground color of the matched text in the completion.
# Type: QssColor
c.colors.completion.match.fg = hue_6

# Color of the scrollbar in completion view
# Type: QssColor
c.colors.completion.scrollbar.bg = "{background}"

# Color of the scrollbar handle in completion view.
# Type: QssColor
c.colors.completion.scrollbar.fg = mono_4

# Background color for the download bar.
# Type: QssColor
c.colors.downloads.bar.bg = "{background}"

# Background color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.bg = hue_5

# Foreground color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.fg = "{background}"

c.colors.downloads.start.bg = hue_1
c.colors.downloads.start.fg = "{background}"

# Color gradient stop for download backgrounds.
# Type: QtColor
c.colors.downloads.stop.bg = hue_4

c.colors.downloads.stop.fg = "{background}"

# Color gradient interpolation system for download backgrounds.
# Type: ColorSystem
# Valid values:
#   - rgb: Interpolate in the RGB color system.
#   - hsv: Interpolate in the HSV color system.
#   - hsl: Interpolate in the HSL color system.
#   - none: Don't show a gradient.
c.colors.downloads.system.bg = 'none'
c.colors.downloads.system.fg = 'rgb'

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
# Type: QssColor
c.colors.hints.bg = hue_6_3

# Font color for hints.
# Type: QssColor
c.colors.hints.fg = "{background}"

# Font color for the matched part of hints.
# Type: QssColor
c.colors.hints.match.fg = hue_4

# Background color of the keyhint widget.
# Type: QssColor
c.colors.keyhint.bg = hue_5_2

# Text color for the keyhint widget.
# Type: QssColor
c.colors.keyhint.fg = hue_6_2

# Highlight color for keys to complete the current keychain.
# Type: QssColor
c.colors.keyhint.suffix.fg = syntax_cursor

# Background color of an error message.
# Type: QssColor
c.colors.messages.error.bg = hue_5

# Border color of an error message.
# Type: QssColor
c.colors.messages.error.border =  "{background}"

# Foreground color of an error message.
# Type: QssColor
c.colors.messages.error.fg = "{background}"

# Background color of an info message.
# Type: QssColor
c.colors.messages.info.bg = hue_2

# Border color of an info message.
# Type: QssColor
c.colors.messages.info.border = hue_2

# Foreground color an info message.
# Type: QssColor
c.colors.messages.info.fg = "{background}"

# Background color of a warning message.
# Type: QssColor
c.colors.messages.warning.bg = hue_5

# Border color of a warning message.
# Type: QssColor
c.colors.messages.warning.border = hue_5

# Foreground color a warning message.
# Type: QssColor
c.colors.messages.warning.fg = "{background}"

# Background color for prompts.
# Type: QssColor
c.colors.prompts.bg = "{background}"

# # Border used around UI elements in prompts.
# # Type: String
c.colors.prompts.border = '1px solid {background}'

# Foreground color for prompts.
# Type: QssColor
c.colors.prompts.fg = "{foreground}"

# Background color for the selected item in filename prompts.
# Type: QssColor
c.colors.prompts.selected.bg = hue_3

# Background color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.bg = hue_3

# Foreground color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.fg = "{background}"

# Background color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.bg = hue_3

# Foreground color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.fg = "{background}"

# Background color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.bg = "{background}"

# Foreground color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.fg = "{foreground}"

# Background color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.bg = "{background}"

# Foreground color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.fg = "{foreground}"

# Background color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.bg = hue_2

# Foreground color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.fg = "{background}"

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = hue_4

# Foreground color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.fg = "{background}"

# Background color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.bg = hue_5

# Foreground color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.fg = "{background}"

# Background color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.bg = mono_4

# Foreground color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.fg = "{background}"

# Background color of the progress bar.
# Type: QssColor
c.colors.statusbar.progress.bg = hue_1

# Foreground color of the URL in the statusbar on error.
# Type: QssColor
c.colors.statusbar.url.error.fg = special_grey #hue_5

# Default foreground color of the URL in the statusbar.
# Type: QssColor
c.colors.statusbar.url.fg = special_grey #"{background}"

# Foreground color of the URL in the statusbar for hovered links.
# Type: QssColor
c.colors.statusbar.url.hover.fg = special_grey #hue_2

# Foreground color of the URL in the statusbar on successful load
# (http).
# Type: QssColor
c.colors.statusbar.url.success.http.fg = special_grey #hue_4

# Foreground color of the URL in the statusbar on successful load
# (https).
# Type: QssColor
c.colors.statusbar.url.success.https.fg = special_grey #hue_4

# Foreground color of the URL in the statusbar when there's a warning.
# Type: QssColor
c.colors.statusbar.url.warn.fg = special_grey #hue_6

# Background color of the tab bar.
# Type: QtColor
c.colors.tabs.bar.bg = "{background}" #"rgba(0,0,0,0)" # alpha of <255 to make transparent

# Background color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.bg = syntax_cursor

# Foreground color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.fg = "{foreground}"

# Color for the tab indicator on errors.
# Type: QtColor
c.colors.tabs.indicator.error = hue_5

# Color gradient start for the tab indicator.
# Type: QtColor
# c.colors.tabs.indicator.start = "{color5}"

# Color gradient end for the tab indicator.
# Type: QtColor
# c.colors.tabs.indicator.stop = "{color1}"

# Color gradient interpolation system for the tab indicator.
# Type: ColorSystem
# Valid values:
#   - rgb: Interpolate in the RGB color system.
#   - hsv: Interpolate in the HSV color system.
#   - hsl: Interpolate in the HSL color system.
#   - none: Don't show a gradient.
c.colors.tabs.indicator.system = 'none'

# Background color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.bg = visual_grey

# Foreground color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.fg = "{foreground}"

c.colors.tabs.pinned.even.bg = "{foreground}"
c.colors.tabs.pinned.even.fg = hue_2
c.colors.tabs.pinned.odd.bg = mono_5
c.colors.tabs.pinned.odd.fg = hue_2
c.colors.tabs.pinned.selected.even.bg = hue_6_2
c.colors.tabs.pinned.selected.even.fg = "{background}"
c.colors.tabs.pinned.selected.odd.bg = hue_6_2
c.colors.tabs.pinned.selected.odd.fg = "{background}"

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = hue_4

# Foreground color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.fg = "{background}"

# Background color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.bg = hue_4

# Foreground color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.fg = "{background}"

# Background color for webpages if unset (or empty to use the theme's
# color)
# Type: QtColor
# c.colors.webpage.bg = "{foreground}"

if qutewal_dynamic_loading or bool(os.getenv('QUTEWAL_DYNAMIC_LOADING')):
    import signal
    import subprocess
    import prctl

    # start iqutefy to refresh colors on the fly
    qutewald = subprocess.Popen(
        [daemon_absolute, colors_absolute],
        preexec_fn=lambda: prctl.set_pdeathsig(signal.SIGTERM))
