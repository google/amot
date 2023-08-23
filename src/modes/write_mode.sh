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

__amot_write_mode() {
	local input_mode=$1

	# Here, we use emacs because viins rather infuriatingly prevents backspacing into the
	# input buffer without pressing Esc.
	if [[ $input_mode == "$MANUAL_WRITE_MODE" ]]; then
		__write_vared_prompt
	elif [[ $input_mode == "$AUTOMATIC_WRITE_MODE" ]]; then
		: # Left empty for clarity.
	else
		echo "Entered write mode with invalid input mode. This should never happen; please report me as a bug!"
		return 1
	fi

	if [[ ! -z $write_mode_input ]]; then
		escaped_input=$write_mode_input

		# ADB has a number of special characters that need to be escaped when providing
		# text input. This list may be incomplete.
		escape_chars=("(" ")" "<" ">" "|" ";" "&" "*" "~" "\"" "'" " ")

		# Go through each special character and escape it with a backslash.
		for escape_char in $escape_chars; do
			escaped_input=$(echo "$escaped_input" | sed "s/$escape_char/\\\\$escape_char/g")
		done

		# This command can take a while. We don't hang the UI here, though it does mean the user
		# can do weird things like move focus while adb is still writing.
		(adb &>/dev/null -s $serial shell input text "$escaped_input" &)

		__write_formatted_output "$(date +"%H:%M:%S")" "\"$write_mode_input\""
	fi

	# Wipe the write input buffer for the next input.
	write_mode_input=""
}
