#!/bin/zsh

# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# We need this because Macs don't have "timeout" as a default command.
# However, both Mac and Linux machines (typically) have perl...
amot_timeout() {
	PERL_BADLANG=0 perl -e 'alarm shift; exec @ARGV' "$@"
}

# Ensures the user's environment can support running amot.
__amot_check_env() {

	# Ensures that the calling shell in zsh.
	if [ -n "$ZSH_VERSION" ]; then
		: # Left blank for clarity.
	elif [ -n "$BASH_VERSION" ]; then
		echo >&2 "Bash detected. Amot will malfunction. Aborting."
		exit 51
	else
		echo >&2 "Unsure of shell. Amot may malfunction. Aborting."
		exit 51
	fi

	# Ensures that the user has adb installed.
	if ! type adb &>/dev/null; then
		echo >&2 "amot requires ADB to be installed for correct operation. Aborting."
		exit 52
	fi

	# Ensures that the user has fzf 0.40.0 or later installed.
	autoload is-at-least
	if ! command -v fzf &>/dev/null || ! is-at-least $REQUIRED_FZF_VERSION $(fzf --version | cut -d' ' -f1); then
		echo >&2 "amot requires fzf 0.40.0 or higher to be installed for correct operation. Aborting."
		exit 53
	fi

	# Ensures that the user has perl installed.
	if ! command -v perl &>/dev/null; then
		echo >&2 "amot requires perl to be installed for correct operation. Aborting."
		exit 54
	fi
}

__amot_check_env
