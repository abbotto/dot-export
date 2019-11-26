#!/usr/bin/env sh

pass_count=0
fail_count=0

check_value(){
    if [ "${1}" = 1 ]; then
        pass_count=$((pass_count+1))
    else
        fail_count=$((fail_count+1))
    fi
}
