#!/usr/bin/env bash

current_brightness=$(cat "/sys/class/backlight/amdgpu_bl1/brightness")
max_brightness=$(cat "/sys/class/backlight/amdgpu_bl1/max_brightness")

#echo $max_brightness
step=$(echo "${max_brightness} / 20" | bc -l | xargs printf %.f)
#echo $step
new_value=$(echo "${current_brightness} + ${step}" | bc)
new_value=$((${new_value} > ${max_brightness} ? ${max_brightness} : ${new_value} ))
echo "Setting display brightness to ${new_value}"

echo ${new_value} > /sys/class/backlight/amdgpu_bl1/brightness
