config.load_autoconfig()

# =============================================================================
# Theme
# =============================================================================
Dracula = {
    "bg": "#282a36",
    "current": "#44475a",
    "fg": "#f8f8f2",
    "comment": "#6272a4",
    "cyan": "#8be9fd",
    "green": "#50fa7b",
    "orange": "#ffb86c",
    "pink": "#ff79c6",
    "purple": "#bd93f9",
    "red": "#ff5555",
    "yellow": "#f1fa8c",
}

# =============================================================================
# Colors
# =============================================================================
c.colors.tabs.selected.even.bg = Dracula["purple"]
c.colors.tabs.selected.even.fg = Dracula["bg"]
c.colors.tabs.selected.odd.bg = Dracula["purple"]
c.colors.tabs.selected.odd.fg = Dracula["bg"]
c.colors.tabs.indicator.start = Dracula["cyan"]
c.colors.tabs.indicator.stop = Dracula["purple"]
c.colors.tabs.indicator.error = Dracula["red"]
c.colors.statusbar.normal.bg = Dracula["bg"]
c.colors.statusbar.normal.fg = Dracula["fg"]
c.colors.statusbar.insert.bg = Dracula["current"]
c.colors.statusbar.insert.fg = Dracula["cyan"]
c.colors.statusbar.command.bg = Dracula["bg"]
c.colors.statusbar.command.fg = Dracula["fg"]
c.colors.statusbar.command.private.bg = Dracula["bg"]
c.colors.statusbar.command.private.fg = Dracula["fg"]
c.colors.statusbar.caret.bg = Dracula["current"]
c.colors.statusbar.caret.fg = Dracula["yellow"]
c.colors.statusbar.passthrough.bg = Dracula["current"]
c.colors.statusbar.passthrough.fg = Dracula["green"]
c.colors.statusbar.url.error.fg = Dracula["red"]
c.colors.statusbar.url.hover.fg = Dracula["purple"]
c.colors.statusbar.url.success.http.fg = Dracula["orange"]
c.colors.statusbar.url.success.https.fg = Dracula["green"]
c.colors.statusbar.url.warn.fg = Dracula["yellow"]
c.colors.prompts.bg = Dracula["bg"]
c.colors.prompts.fg = Dracula["fg"]
c.colors.prompts.border = f"1px solid {Dracula['current']}"
c.colors.prompts.selected.bg = Dracula["purple"]
c.colors.completion.category.bg = Dracula["bg"]
c.colors.completion.category.fg = Dracula["purple"]
c.colors.completion.category.border.top = Dracula["current"]
c.colors.completion.category.border.bottom = Dracula["current"]
c.colors.completion.even.bg = Dracula["bg"]
c.colors.completion.odd.bg = Dracula["bg"]
c.colors.completion.item.selected.bg = Dracula["current"]
c.colors.completion.item.selected.fg = Dracula["fg"]
c.colors.completion.item.selected.match.fg = Dracula["purple"]
c.colors.completion.fg = Dracula["fg"]
c.colors.completion.match.fg = Dracula["purple"]
c.colors.completion.scrollbar.bg = Dracula["bg"]
c.colors.completion.scrollbar.fg = Dracula["fg"]
c.colors.downloads.bar.bg = Dracula["bg"]
c.colors.downloads.start.bg = Dracula["bg"]
c.colors.downloads.start.fg = Dracula["fg"]
c.colors.downloads.stop.bg = Dracula["purple"]
c.colors.downloads.stop.fg = Dracula["bg"]
c.colors.downloads.error.bg = Dracula["red"]
c.colors.downloads.error.fg = Dracula["fg"]
c.colors.hints.fg = Dracula["bg"]
c.colors.hints.bg = Dracula["purple"]
c.colors.hints.match.fg = Dracula["fg"]
c.colors.keyhint.fg = Dracula["fg"]
c.colors.keyhint.suffix.fg = Dracula["fg"]
c.colors.keyhint.bg = Dracula["bg"]
c.colors.messages.error.bg = Dracula["red"]
c.colors.messages.error.fg = Dracula["fg"]
c.colors.messages.error.border = Dracula["red"]
c.colors.messages.warning.bg = Dracula["yellow"]
c.colors.messages.warning.fg = Dracula["bg"]
c.colors.messages.warning.border = Dracula["yellow"]
c.colors.messages.info.bg = Dracula["bg"]
c.colors.messages.info.fg = Dracula["fg"]
c.colors.messages.info.border = Dracula["current"]
c.colors.webpage.preferred_color_scheme = "dark"

# =============================================================================
# Dark mode
# =============================================================================
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"

# =============================================================================
# Fonts
# =============================================================================
c.fonts.default_family = "Pragmasevka Nerd Font"
c.fonts.default_size = "11pt"
c.fonts.tabs.selected = "11pt Pragmasevka Nerd Font"
c.fonts.tabs.unselected = "11pt Pragmasevka Nerd Font"
c.fonts.statusbar = "11pt Pragmasevka Nerd Font"
c.fonts.prompts = "11pt Pragmasevka Nerd Font"
c.fonts.downloads = "11pt Pragmasevka Nerd Font"
c.fonts.keyhint = "11pt Pragmasevka Nerd Font"
c.fonts.completion.entry = "11pt Pragmasevka Nerd Font"
c.fonts.completion.category = "11pt Pragmasevka Nerd Font"

# =============================================================================
# URLs & Search
# =============================================================================
c.url.default_page = "http://localhost:8087"
c.url.start_pages = ["http://localhost:8087"]
c.url.auto_search = "naive"
c.url.searchengines = {
    "DEFAULT": "http://localhost:8087/search?q={}",
    "!a": "https://wiki.archlinux.org/?search={}",
    "!aw": "https://wiki.archlinux.org/?search={}",
    "!n": "https://wiki.nixos.org/?search={}",
    "!nix": "https://wiki.nixos.org/?search={}",
    "!np": "https://search.nixos.org/packages?query={}",
    "!no": "https://search.nixos.org/options?query={}",
    "!gh": "https://github.com/search?q={}",
    "!r": "https://reddit.com/r/{}",
    "!yt": "https://youtube.com/results?search_query={}",
    "!w": "https://en.wikipedia.org/wiki/{}",
    "!m": "https://www.google.com/maps?q={}",
    "!so": "https://stackoverflow.com/search?q={}",
}

# =============================================================================
# Tabs
# =============================================================================
c.tabs.position = "top"
c.tabs.show = "multiple"
c.tabs.indicator.width = 3
c.tabs.favicons.scale = 1.0
c.tabs.title.format = "{audio}{current_title}"
c.tabs.mousewheel_switching = False
c.tabs.new_position.related = "next"
c.tabs.new_position.unrelated = "last"

# =============================================================================
# Statusbar
# =============================================================================
c.statusbar.show = "in-mode"
c.statusbar.padding = {"top": 4, "bottom": 4, "left": 6, "right": 6}

# =============================================================================
# Downloads
# =============================================================================
c.downloads.position = "bottom"
c.downloads.remove_finished = 5000

# =============================================================================
# Scrolling
# =============================================================================
c.scrolling.smooth = True
c.scrolling.bar = "always"

# =============================================================================
# Completion
# =============================================================================
c.completion.height = "35%"
c.completion.show = "always"

# =============================================================================
# Content & Privacy
# =============================================================================
c.content.autoplay = False
c.content.notifications.enabled = False
c.content.geolocation = False
c.content.cookies.store = True
c.content.cookies.accept = "no-3rdparty"
c.content.blocking.enabled = True
c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",
]
c.content.headers.user_agent = (
    "Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0"
)
c.content.headers.accept_language = "en-US,en;q=0.9"
c.content.javascript.log_message.levels = {"userscript:_qute_js": ["error"]}

# =============================================================================
# Zoom
# =============================================================================
c.zoom.default = "100%"
c.zoom.mouse_divider = 512

# =============================================================================
# Editor
# =============================================================================
c.editor.command = ["alacritty", "-e", "nvim", "{file}", "-c", "normal {line}G{column}l"]

# =============================================================================
# Hints
# =============================================================================
c.hints.auto_follow = "unique-match"
c.hints.border = "1px solid #44475a"
c.hints.uppercase = True
c.hints.scatter = True

# =============================================================================
# Input
# =============================================================================
c.input.insert_mode.auto_load = False
c.input.insert_mode.auto_leave = True
c.input.partial_timeout = 5000

# =============================================================================
# Session
# =============================================================================
c.confirm_quit = ["downloads"]
c.auto_save.session = True
c.session.default_name = "default"

# =============================================================================
# Aliases
# =============================================================================
c.aliases = {
    "q": "close",
    "qa": "quit",
    "w": "session-save",
    "wq": "quit --save",
    "e": "open editor",
    "h": "back",
    "l": "forward",
}

# =============================================================================
# Keybinds - Normal Mode
# (default mode, press <Escape> from any other mode to return)
# =============================================================================

# Navigation
config.bind("H", "back")
config.bind("L", "forward")
config.bind("J", "tab-prev")
config.bind("K", "tab-next")
config.bind("r", "reload")
config.bind("R", "reload --force")
config.bind("gg", "scroll-to-perc 0")
config.bind("G", "scroll-to-perc")
config.bind("j", "scroll down")
config.bind("k", "scroll up")
config.bind("h", "scroll left")
config.bind("l", "scroll right")
config.bind("<Ctrl+d>", "scroll-page 0 0.5")
config.bind("<Ctrl+u>", "scroll-page 0 -0.5")
config.bind("<Ctrl+f>", "scroll-page 0 1")
config.bind("<Ctrl+b>", "scroll-page 0 -1")
config.bind("[[", "navigate prev")
config.bind("]]", "navigate next")
config.bind("<Alt+Left>", "back")
config.bind("<Alt+Right>", "forward")

# Tabs
config.bind("t", "open -t")
config.bind("T", "cmd-set-text -s :open -t")
config.bind("o", "cmd-set-text -s :open")
config.bind("O", "cmd-set-text -s :open -t")
config.bind("d", "tab-close")
config.bind("u", "undo")
config.bind("U", "undo --window")
config.bind("<Ctrl+t>", "open -t")
config.bind("<Ctrl+w>", "tab-close")
config.bind("<Ctrl+Tab>", "tab-next")
config.bind("<Ctrl+Shift+Tab>", "tab-prev")
config.bind("<Ctrl+Shift+]>", "tab-move +")
config.bind("<Ctrl+Shift+[>", "tab-move -")
config.bind("1", "tab-focus 1")
config.bind("2", "tab-focus 2")
config.bind("3", "tab-focus 3")
config.bind("4", "tab-focus 4")
config.bind("5", "tab-focus 5")
config.bind("6", "tab-focus 6")
config.bind("7", "tab-focus 7")
config.bind("8", "tab-focus 8")
config.bind("9", "tab-focus 9")
config.bind("g0", "tab-focus 1")
config.bind("g$", "tab-focus -1")
config.bind("gp", "tab-pin")
config.bind("gm", "tab-mute")
config.bind("gl", "tab-move -")
config.bind("gr", "tab-move +")

# Open / URL
config.bind("p", "open -- {clipboard}")
config.bind("P", "open -t -- {clipboard}")
config.bind("go", "cmd-set-text :open {url:pretty}")
config.bind("gO", "cmd-set-text :open -t {url:pretty}")

# Search
config.bind("/", "cmd-set-text /")
config.bind("?", "cmd-set-text ?")
config.bind("n", "search-next")
config.bind("N", "search-prev")
config.bind("<Escape>", "mode-leave ;; clear-messages ;; search --clear")

# Hints
config.bind("f", "hint")
config.bind("F", "hint links tab")
config.bind(";f", "hint all tab")
config.bind(";b", "hint all tab-bg")
config.bind(";i", "hint images")
config.bind(";I", "hint images tab")
config.bind(";o", "hint links fill :open {hint-url}")
config.bind(";O", "hint links fill :open -t {hint-url}")
config.bind(";d", "hint links download")
config.bind(";y", "hint links yank")
config.bind(";Y", "hint links yank-primary")
config.bind(";v", "hint links spawn --detach mpv {hint-url}")
config.bind(";r", "hint --rapid")
config.bind("gi", "hint inputs --first")

# Yank
config.bind("yy", "yank")
config.bind("yt", "yank title")
config.bind("yu", "yank")
config.bind("ym", "yank markdown")
config.bind("yp", "yank pretty-url")
config.bind("yd", "yank domain")

# Marks / jumps
config.bind("'", "mode-enter jump_mark")
config.bind("`", "mode-enter jump_mark")
config.bind("m", "mode-enter set_mark")

# Zoom
config.bind("+", "zoom-in")
config.bind("-", "zoom-out")
config.bind("=", "zoom")
config.bind("<Ctrl+=>", "zoom-in")
config.bind("<Ctrl+->", "zoom-out")
config.bind("<Ctrl+0>", "zoom")

# Page actions
config.bind("gf", "view-source")
config.bind("gF", "devtools")
config.bind("gd", "devtools")
config.bind(":", "cmd-set-text :")
config.bind(".", "repeat-command")

# Downloads
config.bind("gD", "download")
config.bind("cd", "download-cancel")

# Bookmarks & quickmarks
config.bind("B", "cmd-set-text -s :bookmark-load -t")
config.bind("b", "cmd-set-text -s :bookmark-load")
config.bind("M", "bookmark-add")
config.bind(",m", "cmd-set-text -s :quickmark-load")
config.bind(",M", "cmd-set-text -s :quickmark-load -t")
config.bind(",s", "quickmark-save")

# Modes
config.bind("i", "enter-mode insert")
config.bind("v", "enter-mode caret")
config.bind("V", "enter-mode passthrough")

# Adblock
config.bind(",au", "adblock-update")

# Print / save
config.bind(",p", "print")
config.bind(",P", "print --pdf")

# History / internal pages
config.bind("gh", "open qute://history")
config.bind("gs", "open qute://settings")
config.bind("gk", "open qute://bindings")
config.bind("gH", "open -t qute://history")

# Media
config.bind(
    "gv",
    "spawn --detach mpv {url} --ytdl-format=bestvideo[height<=1080]+bestaudio/best",
)

# Kill overlays (cookie banners etc)
config.bind(
    ",ko",
    "jseval (function () { var i, elements = document.querySelectorAll('body *'); for (i = 0; i < elements.length; i++) { var pos = getComputedStyle(elements[i]).position; if (pos === 'fixed' || pos == 'sticky') { elements[i].parentNode.removeChild(elements[i]); } } })();",
)

# Quit
config.bind("ZZ", "quit --save")
config.bind("ZQ", "quit")
config.bind("<Ctrl+q>", "quit")

# Misc
config.bind("<Ctrl+Return>", "open -t")
config.bind("<Alt+Return>", "hint --tab")
config.bind("<Ctrl+n>", "completion-item-focus --history next")
config.bind("<Ctrl+p>", "completion-item-focus --history prev")

# =============================================================================
# Keybinds - Insert Mode
# (press i in normal mode, or click a text field — lets you type on the page)
# =============================================================================
config.bind("<Escape>", "mode-leave", mode="insert")
config.bind("<Ctrl+e>", "open-editor", mode="insert")
config.bind("<Ctrl+v>", "insert-text -- {clipboard}", mode="insert")

# =============================================================================
# Keybinds - Caret Mode
# (press v in normal mode — vim-style text selection with the keyboard)
# =============================================================================
config.bind("v", "toggle-selection", mode="caret")
config.bind("V", "toggle-selection --line", mode="caret")
config.bind("y", "yank selection", mode="caret")
config.bind("q", "mode-leave", mode="caret")
config.bind("<Escape>", "mode-leave", mode="caret")
config.bind("h", "move-to-prev-char", mode="caret")
config.bind("l", "move-to-next-char", mode="caret")
config.bind("j", "move-to-next-line", mode="caret")
config.bind("k", "move-to-prev-line", mode="caret")
config.bind("w", "move-to-next-word", mode="caret")
config.bind("b", "move-to-prev-word", mode="caret")
config.bind("e", "move-to-end-of-word", mode="caret")
config.bind("0", "move-to-start-of-line", mode="caret")
config.bind("$", "move-to-end-of-line", mode="caret")
config.bind("gg", "move-to-start-of-document", mode="caret")
config.bind("G", "move-to-end-of-document", mode="caret")
config.bind("<Ctrl+d>", "scroll-page 0 0.5", mode="caret")
config.bind("<Ctrl+u>", "scroll-page 0 -0.5", mode="caret")

# =============================================================================
# Keybinds - Passthrough Mode
# (press V in normal mode — all keypresses go straight to the page, nothing intercepted)
# =============================================================================
config.bind("<Escape>", "mode-leave", mode="passthrough")

# =============================================================================
# Keybinds - Hint Mode
# (press f or F in normal mode — labels appear on links for keyboard navigation)
# =============================================================================
config.bind("<Escape>", "mode-leave", mode="hint")
config.bind("<Ctrl+c>", "mode-leave", mode="hint")

# =============================================================================
# Keybinds - Command Mode
# (press : in normal mode — type qutebrowser commands directly)
# =============================================================================
config.bind("<Ctrl+c>", "mode-leave", mode="command")
config.bind("<Escape>", "mode-leave", mode="command")
config.bind("<Ctrl+n>", "completion-item-focus --history next", mode="command")
config.bind("<Ctrl+p>", "completion-item-focus --history prev", mode="command")
config.bind("<Tab>", "completion-item-focus next", mode="command")
config.bind("<Shift+Tab>", "completion-item-focus prev", mode="command")
config.bind("<Up>", "completion-item-focus --history prev", mode="command")
config.bind("<Down>", "completion-item-focus --history next", mode="command")
config.bind("<Ctrl+d>", "completion-item-del", mode="command")

# =============================================================================
# Keybinds - Prompt Mode
# (appears automatically for download location prompts or JS dialogs)
# =============================================================================
config.bind("<Escape>", "mode-leave", mode="prompt")
config.bind("<Return>", "prompt-accept", mode="prompt")
config.bind("<Ctrl+y>", "prompt-accept yes", mode="prompt")
config.bind("<Ctrl+n>", "prompt-accept no", mode="prompt")
config.bind("<Tab>", "prompt-item-focus next", mode="prompt")
config.bind("<Shift+Tab>", "prompt-item-focus prev", mode="prompt")

# =============================================================================
# Keybinds - Yesno Mode
# (appears automatically when qutebrowser asks a yes/no question)
# =============================================================================
config.bind("y", "prompt-accept yes", mode="yesno")
config.bind("n", "prompt-accept no", mode="yesno")
config.bind("<Escape>", "mode-leave", mode="yesno")
