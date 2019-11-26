#!/usr/bin/env sh

. ./test/util/check-value.sh

expect_value(){
    value=$(eval printf '%s\\n' "\$${1}")

    if [ "${value}" != "${2}" ]; then
        exit_code=127;

        printf '%s\n' "| The '${1}' variable has an unexpected value"
        printf '%s\n' "| Expected: '${2}'"
        printf '%s\n' "| Received: '${value}'"

        check_value 0
    else
        check_value 1
    fi
}