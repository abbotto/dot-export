#!/usr/bin/env sh

terminate(){
    if [ -z "${1}" ]; then
        echo "terminate: arguments are missing"
        return 127
    fi

	green=$(tput setaf 2)
	red=$(tput setaf 9)
	no_color=$(tput sgr0)

	pass_msg=""
	fail_msg=""

	if [ -n "${2}" ]; then pass_msg=" ${2}"; fi
	if [ -n "${3}" ]; then fail_msg=" ${3}"; fi

	if [ "${1}" = 0 ]; then printf '%s\n' "${green}✔${pass_msg}${no_color}";
	else printf '%s\n' "${red}❌${fail_msg}${no_color}" >&2; fi

	exit "${1}"
}
