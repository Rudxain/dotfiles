#!/usr/bin/env bash
set -euf
shopt -s expand_aliases

# "density" is inversely proportional to "min width".
# lower "min width" = bigger zoom.
DEFAULT_DPI=480

alias adbsh='adb shell'
alias sett='adbsh settings put global'

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

sett low_power "$power_save_off"

for s in animator_duration_scale transition_animation_scale window_animation_scale
do
	sett "$s" "$half"
done

adbsh wm size "$resolution"
adbsh wm density "$dpi"

adbsh settings put system double_tab_to_wake_up "$power_save_on"

# commented-out, because I always have it enabled
#adbsh settings put system accessibility_reduce_transparency "$power_save_off"
