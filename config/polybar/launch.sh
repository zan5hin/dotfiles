#!/usr/bin/env bash

# Requires:
# * polybar
# * nerd-fonts-complete

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shutdown
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Capture Desktop
desktop=$(echo $DESKTOP_SESSION)

case $desktop in
  i3)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-i3 -c ~/.config/polybar/config &
      done
    else
      polybar --reload mainbar-i3 -c ~/.config/polybar/config &
    fi
    ;;
  openbox)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-openbox -c ~/.config/polybar/config &
      done
    else
      polybar --reload mainbar-openbox -c ~/.config/polybar/config &
    fi
    ;;
  bspwm)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
      done
    else
      polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
    fi
    ;;
esac

# For future scripts - how to find interface
# interface-name=$(ip route | grep '^default' | awk '{print $5}')
# interface-name=$(ifconfig -a | sed -n 's/^|([^ ]\+\.*/\1/p' | grep -Fvx -e
# lo: | sed 's/.$//')


# Terminate any currently running instances
# killall -q polybar

# Pause while killall completes
# while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar(s)
# polybar top -q &
# polybar bottom -q  &
#
# echo "polybars launched..."
