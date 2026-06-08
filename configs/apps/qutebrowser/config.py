config.load_autoconfig()

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

c.aliases = {
    "q": "close",
    "qa": "quit",
    "w": "session-save",
    "wq": "quit --save",
    "e": "open editor",
    "h": "back",
    "l": "forward",
}

# Fonts
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

# URLs
c.url.default_page = "about:blank"
c.url.start_pages = ["about:blank"]
c.url.searchengines = {
    "DEFAULT": "http://localhost:8080/search?q={}",
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
c.url.auto_search = "never"

# Tabs
c.tabs.position = "top"
c.tabs.show = "multiple"
c.tabs.indicator.width = 3
c.tabs.favicons.scale = 1.0
c.tabs.title.format = "{audio}{current_title}"
c.tabs.mousewheel_switching = False
c.tabs.new_position.related = "next"
c.tabs.new_position.unrelated = "last"

# Statusbar
c.statusbar.show = "in-mode"
c.statusbar.padding = {"top": 4, "bottom": 4, "left": 6, "right": 6}

# Downloads
c.downloads.position = "bottom"
c.downloads.remove_finished = 5000

# Scrolling
c.scrolling.smooth = True
c.scrolling.bar = "always"

# Completion
c.completion.height = "35%"
c.completion.show = "always"


# Content / Privacy
c.content.autoplay = False
c.content.notifications.enabled = False
c.content.geolocation = False
c.content.cookies.store = True
c.content.cookies.accept = "all"
c.content.blocking.enabled = True
c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",
]
c.content.headers.user_agent = "Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0"
c.content.headers.accept_language = "en-US,en;q=0.9"


# Zoom
c.zoom.default = "100%"
c.zoom.mouse_divider = 512

# Editor
c.editor.command = ["foot", "-e", "nvim", "{file}", "-c", "normal {line}G{column}l"]

# Hints
c.hints.auto_follow = "unique-match"
c.hints.border = "1px solid #44475a"
c.hints.uppercase = True
c.hints.scatter = True

# Input
c.input.insert_mode.auto_load = False
c.input.insert_mode.auto_leave = True
c.input.partial_timeout = 5000

# Confirm on quit
c.confirm_quit = ["downloads"]

# Auto-save
c.auto_save.session = True

# Sessions
c.session.default_name = "default"

config.bind("J", "tab-prev")
config.bind("K", "tab-next")

config.bind("H", "back")
config.bind("L", "forward")

config.bind("d", "tab-close")
config.bind("D", "undo")

config.bind("u", "undo")

config.bind("f", "hint")
config.bind("F", "hint --tab")

config.bind("gi", "hint inputs --first")

config.bind(";d", "hint links download --force-text")
config.bind(";r", "hint --rapid")
config.bind(";R", "hint --rapid --tab")
config.bind(";y", "hint links yank")
config.bind(";Y", "hint links yank --tab")

config.bind("yf", "yank -f")
config.bind("yt", "yank -t")
config.bind("yd", "yank -d")

config.bind("p", "open")
config.bind("P", "open -t -- {clipboard}")

config.bind("r", "reload")
config.bind("R", "reload --force")

config.bind("s", "stop")
config.bind("S", "stop")

config.bind("v", "enter-mode passthrough")
config.bind("V", "enter-mode caret")

config.bind("i", "enter-mode insert")
config.bind("I", "enter-mode insert")

config.bind("o", "cmd-set-text -s :open")
config.bind("O", "cmd-set-text -s :open -t")
config.bind("T", "cmd-set-text -s :open -b")
config.bind("t", "cmd-set-text -s :open -t")
config.bind("b", "cmd-set-text -s :tab-select")
config.bind("B", "cmd-set-text -s :quickmark-load -t")

config.bind("gB", "cmd-set-text -s :bookmark-load -t")
config.bind("gl", "cmd-set-text -s :open -t -- {url:pretty}")

config.bind("/", "cmd-set-text /")
config.bind("?", "cmd-set-text ?")

config.bind("n", "search-next")
config.bind("N", "search-prev")

config.bind("g0", "tab-focus 1")
config.bind("g$", "tab-focus -1")
config.bind("g1", "tab-focus 1")
config.bind("g2", "tab-focus 2")
config.bind("g3", "tab-focus 3")
config.bind("g4", "tab-focus 4")
config.bind("g5", "tab-focus 5")
config.bind("g6", "tab-focus 6")
config.bind("g7", "tab-focus 7")
config.bind("g8", "tab-focus 8")
config.bind("g9", "tab-focus 9")

config.bind("gf", "view-source")
config.bind("gF", "devtools")

config.bind("gt", "tab-move +")
config.bind("gT", "tab-move -")

config.bind("M", "bookmark-add")
config.bind("gm", "cmd-set-text -s :quickmark-load")
config.bind("gM", "cmd-set-text -s :bookmark-load")

config.bind("[[", "navigate prev")
config.bind("]]", "navigate next")

config.bind("ga", "open -t")
config.bind("gA", "open -t -- {url:pretty}")

config.bind("xp", "print")
config.bind("xf", "print --pdf")

config.bind("yD", "yank -d")
config.bind("yp", "yank pretty-url")
config.bind("yP", "yank pretty-url -t")
config.bind("yy", "yank")
config.bind("yY", "yank -t")
config.bind("yM", "yank -f")

config.bind("ZZ", "quit --save")
config.bind("ZQ", "quit")

config.bind("<Ctrl+a>", "navigate increment")
config.bind("<Ctrl+x>", "navigate decrement")

config.bind("<Ctrl+n>", "completion-item-focus --history next")
config.bind("<Ctrl+p>", "completion-item-focus --history prev")

config.bind("<Ctrl+Return>", "open -t")
config.bind("<Ctrl+z>", "undo --window")

config.bind("<Alt+Return>", "hint --tab")

config.bind("<Escape>", "mode-leave ;; clear-messages ;; search --clear")

# Mouse

config.bind("gv", "spawn --detach mpv {url} --ytdl-format=bestvideo[height<=1080]+bestaudio/best")
config.bind(";v", "hint links spawn mpv {hint-url}")


c.content.javascript.log_message.levels = {"userscript:_qute_js": ["error"]}

c.url.auto_search = "naive"

config.bind("gK", "open qute://bindings")