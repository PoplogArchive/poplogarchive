# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

# Set a background color
BG=""
if which hsetroot >/dev/null; then
    BG=hsetroot
else
    if which esetroot >/dev/null; then
	BG=esetroot
    else
	if which xsetroot >/dev/null; then
	    BG=xsetroot
	fi
    fi
fi
test -z $BG || $BG -solid "#303030"

# D-bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

# Make GTK apps look and behave how they were set up in the gnome config tools
if test -x /usr/libexec/gnome-settings-daemon >/dev/null; then
  /usr/libexec/gnome-settings-daemon &
elif which gnome-settings-daemon >/dev/null; then
  gnome-settings-daemon &
# Make GTK apps look and behave how they were set up in the XFCE config tools
elif which xfce-mcs-manager >/dev/null; then
  xfce-mcs-manager n &
fi

# Preload stuff for KDE apps
if which start_kdeinit >/dev/null; then
  LD_BIND_NOW=true start_kdeinit --new-startup +kcminit_startup &
fi

# Run XDG autostart things.  By default don't run anything desktop-specific
# See xdg-autostart --help more info
DESKTOP_ENV=""
if which /usr/share/openbox/xdg-autostart >/dev/null; then
  /usr/share/openbox/xdg-autostart $DESKTOP_ENV
fi

## Stuff added by AS. Probably only need one clock, but xclock is useful
## for counting seconds and xdaliclock is nice for a biger display.
## later I may add something to show desktop name in each desktop.

(xclock -digital -chime -geom -1+1 -update 1 -font '*-lucida-bold-r-normal-sans-20-*-100-100-p-*-*-1' &)

(/usr/bin/xdaliclock -builtin1 -noseconds -24 -geom -0+550 & )

(sleep 5 && xrdb .Xdefaults && xterm -fn 10x20 -geom 90x49+5+5 -ls -title GROMIT) &
