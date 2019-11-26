#!/usr/bin/env sh

set -eu

arg="${1:-}"

cd "$(npm prefix)"

pkg=$(npm version | head -n 1)
pkg_name=$(echo "${pkg}" | sed "s/{ '\(.*\)':.*/\1/")
local_pkg_version=$(echo "${pkg}" | grep -o -e '[0-9]*\.[0-9]*\.[0-9]*')
remote_pkg_version=$(npm dist-tag | awk '{print $2}')

check_local_pkg_version=$(echo "${local_pkg_version}" | sed 's/[.]//2g')
check_remote_pkg_version=$(echo "${remote_pkg_version}" | sed 's/[.]//2g')

printf '%s\n' "INFO" "Attempting to publish '${pkg_name}' to the NPM registry..."

if test "$(echo "${check_local_pkg_version}" > "${check_remote_pkg_version}" | bc)" = 1; then
	printf '%s\n' "INFO" "The local package version (${local_pkg_version}) is different from the remote package version (${remote_pkg_version})"
	printf '%s\n' "INFO" "Package version has been bumped - deploying..."

	# npm publish

	if [ "${?}" = 0 ]; then
		printf '%s\n' "INFO" "The package has been published"
	fi
else
	printf '%s\n' "WARN" "The local package version (${local_pkg_version}) does not exceed the remote package version (${remote_pkg_version})"
	printf '%s\n' "WARN" "Package version is too low - skipping deployment"
fi
