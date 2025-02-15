#!/usr/bin/env bash

# Change this according to your device
################
# Variables
################

# Date and time
date_and_week=$(date "+%Y-%m-%d")
current_time=$(date "+%H:%M")

#############
# Commands
#############

# Battery or charger
battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | grep -E "percentage" | awk '{print $2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | grep -E "state" | awk '{print $2}')

# Audio and multimedia
active_audio_source=$(pactl list sinks short | grep RUNNING | awk '{print $1}')
audio_volume="n/a"
audio_is_muted=false

# We check if there is an active audio source. Otherwise, pamixer crashes and
# creates a coredump everytime the script is run (basically every few seconds).
if [[ -n ${active_audio_source} ]]; then
	audio_volume=$(pamixer --sink "${active_audio_source}" --get-volume)
	audio_is_muted=$(pamixer --sink "${active_audio_source}" --get-mute)
fi

# LAN_IF_NAME
LAN_IF_NAME=$(ip -br a | cut -d' ' -f1 | tr ' ' '\n' | grep -P e\.\*)
lan_interface_name=${LAN_IF_NAME}
ip_address=$(ip -o -4 addr list ${LAN_IF_NAME} | awk '{print $4}' | cut -d'/' -f1)

# Wifi
WLAN_IF_NAME=$(ip -br a | cut -d' ' -f1 | tr ' ' '\n' | grep -P w\.\*)
wlan_ip=$(ip -o -4 addr list ${WLAN_IF_NAME} | awk '{print $4}' | cut -d'/' -f1)


# Others
language=$(swaymsg -t get_inputs | grep active_layout_name | head -n 1 | tr -d '"' | cut -d':' -f2 | tr -d ',' | tr -d ' ')

#loadavg_5min=$(cat /proc/loadavg | awk -F ' ' '{print $2}')
loadavg_5min=$(awk -F ' ' '{print $2}' </proc/loadavg)

# Removed weather because we are requesting it too many times to have a proper
# refresh on the bar
#weather=$(curl -Ss 'https://wttr.in/Pontevedra?0&T&Q&format=1')

if [ "$LAN_IF_NAME" ]; then
	lan_speed=$(cat /sys/class/net/eth0/speed)
fi

if [ "$WLAN_IF_NAME" ]; then
	wlan_speed_rx=$(iw dev ${WLAN_IF_NAME} link | grep "rx bitrate" | cut -d' ' -f3)
	wlan_speed_tx=$(iw dev ${WLAN_IF_NAME} link | grep "tx bitrate" | cut -d' ' -f3)
fi

#if [ $player_status = "Playing" ]
#then
#    song_status='▶'
#elif [ $player_status = "Paused" ]
#then
#    song_status='⏸'
#else
#    song_status='⏹'
#fi

if [ "$audio_is_muted" = "true" ]; then
	audio_active='muted'
else
	audio_active='Vol'
fi

disk_space_root=$(df -h --output=avail / | tail -n1 | tr -d ' ')

status_line=""
if [ ${battery_status} != "" ]; then
	status_line="${status_line} | BAT: ${battery_charge} (${battery_status})"
fi
status_line="${status_line} | ${language}"
status_line="${status_line} | / ${disk_space_root}"
if [ $(cat /sys/class/net/${LAN_IF_NAME}/carrier) -eq "1" ]; then
	status_line="${status_line} | ${lan_interface_name}: ${ip_address} (${lan_speed} MBit/s)"
else
	status_line="${status_line} | ${lan_interface_name}: down"
fi
if [ $(cat /sys/class/net/${WLAN_IF_NAME}/carrier) -eq "1" ]; then
	status_line="${status_line} | ${WLAN_IF_NAME}: ${wlan_ip} (rx: $wlan_speed_rx, tx: ${wlan_speed_tx} MBit/s)"
else
	status_line="${status_line} | ${WLAN_IF_NAME}: (down)"
fi
status_line="${status_line} | load ${loadavg_5min}"
status_line="${status_line} | audio: ${audio_active} ${audio_volume}%"
status_line="${status_line} | ${date_and_week} ${current_time}"
echo "${status_line}"
