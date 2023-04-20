#!/usr/bin/env bash
set -euf
shopt -s expand_aliases

# This script is VERY implementation-dependent.
# It's specifically designed for my SM-A315G.
# DON'T RUN IT on a device that doesn't support these settings!

# "density" is inversely proportional to "min width".
# lower "min width" = bigger zoom.
DEFAULT_DPI=480

alias adbsh='adb shell'
alias setg='adbsh settings put global'
alias sety='adbsh settings put system'

power_save_on="$(adbsh settings get global low_power)"
if [[ "$power_save_on" == 1 ]]
then
	power_save_off=0
	half=0.5
	resolution=reset
	dpi="$DEFAULT_DPI"
else
	power_save_off=1
	half=0
	resolution=540x1200
	dpi="$(( DEFAULT_DPI / 2 ))"
fi

setg low_power "$power_save_off"

for s in animator_duration_scale transition_animation_scale window_animation_scale
do
	setg "$s" "$half"
done

adbsh wm size "$resolution"
adbsh wm density "$dpi"

sety double_tab_to_wake_up "$power_save_on"
sety charging_info_always "$power_save_on"

# commented-out, because I always have it enabled
#sety accessibility_reduce_transparency "$power_save_off"
