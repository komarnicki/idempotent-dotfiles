#!/usr/bin/env bash

if [ -z "$bootstrap" ]; then
    echo "This file is not intended to be called directly."
    exit 1
fi

color_black='\033[0;30m'
color_blue='\033[0;34m'
color_cyan='\033[0;36m'
color_green='\033[0;32m'
color_purple='\033[0;35m'
color_red='\033[0;31m'
color_reset='\033[0m'
color_white='\033[0;37m'
color_yellow='\033[0;33m'

function task_start() {
    printf "${color_green}→${color_reset} ${1}"
}

function task_stop() {
    printf " ${color_red}❤︎${color_reset} \n"
}
