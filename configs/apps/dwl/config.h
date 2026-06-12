#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

/* appearance */
static const int sloppyfocus               = 1;
static const int bypass_surface_visibility = 0;
static const int smartgaps                 = 0;
static const int monoclegaps               = 0;
static const unsigned int borderpx         = 2;
static const unsigned int gappih           = 10;
static const unsigned int gappiv           = 10;
static const unsigned int gappoh           = 10;
static const unsigned int gappov           = 10;
static const float rootcolor[]             = COLOR(0x282a36ff);
static const float bordercolor[]           = COLOR(0x44475aff);
static const float focuscolor[]            = COLOR(0xbd93f9ff);
static const float urgentcolor[]           = COLOR(0xff5555ff);
static const float fullscreen_bg[]         = {0.0f, 0.0f, 0.0f, 1.0f};

#define TAGCOUNT (9)

static int log_level = WLR_ERROR;

static const Rule rules[] = {
	{ "pavucontrol",          NULL,       0,            1,           -1 },
	{ "nm-connection-editor", NULL,       0,            1,           -1 },
	{ "mpv",                  NULL,       0,            1,           -1 },
};

static const Layout layouts[] = {
	{ "[]=", tile },
	{ "><>", NULL },
	{ "[M]", monocle },
};

static const MonitorRule monrules[] = {
	{ NULL, 0.55f, 1, 1, &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, -1, -1 },
};

static const struct xkb_rule_names xkb_rules = {
	.layout = "gb",
};

static const int repeat_rate = 25;
static const int repeat_delay = 600;

static const int tap_to_click = 1;
static const int tap_and_drag = 1;
static const int drag_lock = 1;
static const int natural_scrolling = 0;
static const int disable_while_typing = 1;
static const int left_handed = 0;
static const int middle_button_emulation = 0;
static const enum libinput_config_scroll_method scroll_method = LIBINPUT_CONFIG_SCROLL_2FG;
static const enum libinput_config_click_method click_method = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;
static const uint32_t send_events_mode = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;
static const enum libinput_config_accel_profile accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE;
static const double accel_speed = 0.0;
static const enum libinput_config_tap_button_map button_map = LIBINPUT_CONFIG_TAP_MAP_LRM;

#define MODKEY WLR_MODIFIER_ALT

#define TAGKEYS(KEY,SKEY,TAG) \
	{ MODKEY,                    KEY,            view,            {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL,  KEY,            toggleview,      {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_SHIFT, SKEY,           tag,             {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT,SKEY,toggletag, {.ui = 1 << TAG} }

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

static const char *termcmd[] = { "alacritty", NULL };
static const char *menucmd[] = { "fuzzel", NULL };

static const Key keys[] = {
	/* App launchers (matching niri keybinds) */
	{ MODKEY,                    XKB_KEY_Return,      spawn,            {.v = termcmd} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Return,      spawn,            SHCMD("alacritty -e zellij") },
	{ MODKEY,                    XKB_KEY_b,           spawn,            {.v = (const char*[]){ "qutebrowser", NULL } } },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_b,           spawn,            {.v = (const char*[]){ "librewolf", NULL } } },
	{ MODKEY,                    XKB_KEY_t,           spawn,            SHCMD("alacritty -e yazi") },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_t,           spawn,            {.v = (const char*[]){ "thunar", NULL } } },
	{ MODKEY,                    XKB_KEY_e,           spawn,            SHCMD("alacritty -e nvim") },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_e,           spawn,            {.v = (const char*[]){ "vscodium", NULL } } },
	{ MODKEY,                    XKB_KEY_s,           spawn,            SHCMD("alacritty -e rmpc") },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_s,           spawn,            {.v = (const char*[]){ "steam", NULL } } },
	{ MODKEY,                    XKB_KEY_v,           spawn,            SHCMD("alacritty -e btop") },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_v,           spawn,            {.v = (const char*[]){ "Vesktop", NULL } } },
	{ MODKEY,                    XKB_KEY_d,           spawn,            {.v = menucmd} },
	{ MODKEY,                    XKB_KEY_space,       spawn,            {.v = (const char*[]){ "noctalia-shell", "ipc", "call", "launcher", "toggle", NULL } } },
	{ MODKEY,                    XKB_KEY_Escape,      spawn,            {.v = (const char*[]){ "noctalia-shell", "ipc", "call", "sessionMenu", "toggle", NULL } } },

	/* Layout management (moved to avoid conflicts with app launchers) */
	{ MODKEY,                    XKB_KEY_u,           setlayout,        {.v = &layouts[0]} },
	{ MODKEY,                    XKB_KEY_i,           setlayout,        {.v = &layouts[1]} },
	{ MODKEY,                    XKB_KEY_o,           setlayout,        {.v = &layouts[2]} },
	{ MODKEY,                    XKB_KEY_y,           incnmaster,       {.i = +1} },
	{ MODKEY,                    XKB_KEY_n,           incnmaster,       {.i = -1} },

	/* Window management */
	{ MODKEY,                    XKB_KEY_f,           togglefullscreen, {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_space,       togglefloating,   {0} },
	{ MODKEY|WLR_MODIFIER_CTRL,  XKB_KEY_q,           killclient,       {0} },

	/* Focus / navigation */
	{ MODKEY,                    XKB_KEY_j,           focusstack,       {.i = +1} },
	{ MODKEY,                    XKB_KEY_k,           focusstack,       {.i = -1} },
	{ MODKEY,                    XKB_KEY_h,           setmfact,         {.f = -0.05f} },
	{ MODKEY,                    XKB_KEY_l,           setmfact,         {.f = +0.05f} },
	{ MODKEY,                    XKB_KEY_Tab,         zoom,             {0} },

	/* Workspace tags */
	TAGKEYS(          XKB_KEY_1, XKB_KEY_exclam,                        0),
	TAGKEYS(          XKB_KEY_2, XKB_KEY_at,                            1),
	TAGKEYS(          XKB_KEY_3, XKB_KEY_numbersign,                    2),
	TAGKEYS(          XKB_KEY_4, XKB_KEY_dollar,                        3),
	TAGKEYS(          XKB_KEY_5, XKB_KEY_percent,                       4),
	TAGKEYS(          XKB_KEY_6, XKB_KEY_asciicircum,                   5),
	TAGKEYS(          XKB_KEY_7, XKB_KEY_ampersand,                     6),
	TAGKEYS(          XKB_KEY_8, XKB_KEY_asterisk,                      7),
	TAGKEYS(          XKB_KEY_9, XKB_KEY_parenleft,                     8),

	/* Media keys */
	{ 0,                       XKB_KEY_XF86AudioRaiseVolume, spawn, SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+") },
	{ 0,                       XKB_KEY_XF86AudioLowerVolume, spawn, SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-") },
	{ 0,                       XKB_KEY_XF86AudioMute,        spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") },
	{ 0,                       XKB_KEY_XF86AudioMicMute,     spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") },
	{ 0,                       XKB_KEY_XF86AudioPlay,        spawn, SHCMD("playerctl play-pause") },
	{ 0,                       XKB_KEY_XF86AudioNext,        spawn, SHCMD("playerctl next") },
	{ 0,                       XKB_KEY_XF86AudioPrev,        spawn, SHCMD("playerctl previous") },
	{ MODKEY|WLR_MODIFIER_CTRL,XKB_KEY_space,                spawn, SHCMD("playerctl play-pause") },
	{ MODKEY|WLR_MODIFIER_CTRL,XKB_KEY_l,                    spawn, SHCMD("playerctl next") },
	{ MODKEY|WLR_MODIFIER_CTRL,XKB_KEY_h,                    spawn, SHCMD("playerctl previous") },

	/* Screenshots */
	{ MODKEY,                    XKB_KEY_x,           spawn,            SHCMD("grim -g \"$(slurp)\" ~/Pictures/Screenshots/Screenshot\\ from\\ $(date '+%Y-%m-%d\\ %H-%M-%S').png") },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_x,           spawn,            SHCMD("grim ~/Pictures/Screenshots/Screenshot\\ from\\ $(date '+%Y-%m-%d\\ %H-%M-%S').png") },

	/* Quit / VT */
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_q,           quit,             {0} },
	{ WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_Terminate_Server, quit, {0} },
#define CHVT(n) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = (n)} }
	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
	CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
};

static const Button buttons[] = {
	{ MODKEY, BTN_LEFT,   moveresize,     {.ui = CurMove} },
	{ MODKEY, BTN_MIDDLE, togglefloating, {0} },
	{ MODKEY, BTN_RIGHT,  moveresize,     {.ui = CurResize} },
};
