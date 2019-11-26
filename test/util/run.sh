#!/usr/bin/env sh

set -eu

printf '\n%s\n' 'Running tests...'

./test/run/lint.test

exit_code=0
pass_count=0
fail_count=0

mkdir -p ./tmp

capture_exit_code(){
    if [ "${?}" = 0 ]; then
        pass_count=$((pass_count+1))
    else
        fail_count=$((fail_count+1))
    fi

    exit_code="$((exit_code + ${?}))"
}

# Generate a temporary 'env' file
echo 'HELLO="WORLD"' | tee ./tmp/.env.test >/dev/null 2>&1

# Run the test
./test/run/dot-export.test
capture_exit_code

# echo ""
# echo "------------------------"
# echo "Test(s): ${pass_count} passed, ${fail_count} failed"
# echo "------------------------"

rm -rf ./tmp

if [ "${exit_code}" != 0 ]; then
    exit 1
fi

set +eu
