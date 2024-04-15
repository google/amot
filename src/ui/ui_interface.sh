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

__print_status_bar() {
	printf "\33[2K\r"
	echo -e "————————————————————"
}

__write_vared_prompt() {
	__pop_stack

	__print_status_bar

	# Mac has an error that I can't parse using the emacs keymap, so I've muted it.
	vared -M emacs -e -p $'   \e[0;1mWrite Mode\033[0m\t\e[0;32mText:\033[0m ' -c write_mode_input 2> /dev/null

	ui_stack+=('vared_prompt')
}

__write_formatted_prompt() {
	__pop_stack

	local formatted_string="   "
	for param in "$@"; do
		formatted_string+="$param\t"
	done

	__print_status_bar

	# Delete the trailing tab.
	echo -n -e ${formatted_string::-2}

	ui_stack+=('single_prompt')
}

__write_formatted_two_line_prompt() {
	__pop_stack

	local formatted_line_1="   "
	local formatted_line_2="   "

	line_number="1"

	for param in "$@"; do
		if [[ "$param" == "\\" ]]; then
			local line_number="2"
			continue
		fi

		if [[ "$line_number" == "1" ]]; then
			formatted_line_1+="$param\t"
		elif [[ "$line_number" == "2" ]]; then
			formatted_line_2+="$param\t"
		fi
	done

	__print_status_bar

	# Delete the trailing tab.
	echo -e ${formatted_line_1::-2}
	__print_status_bar
	echo -n -e ${formatted_line_2::-2}

	ui_stack+=('double_prompt')
}

__write_find_mode_output() {
	__pop_stack

	# Print the log of submitted commands, then remove it.
	temp_file_logs=$(cat $temp_file)
	if [[ ! -z "${temp_file_logs// /}" ]]; then
		echo $temp_file_logs
	fi
}

__write_formatted_output() {
	__pop_stack

	local formatted_string="   "
	for param in "$@"; do
		formatted_string+="$param\t"
	done

	echo $formatted_string

	ui_stack+=('output')
}
