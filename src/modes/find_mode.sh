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

__amot_find_mode() {
	__write_formatted_prompt "${ansi_bold}Find Mode${ansi_end}"

	# We'll use this file to keep track of what commands have been entered.
	temp_file=$(mktemp)

	# We'll use this file in case we need to switch modes after exit.
	temp_file_mode=$(mktemp)

	# Bind: Enter - Submit the selected keycode through adb.
	enter_cmd=(
		'execute-silent('
		'full_key_line={};'
		"serial=$serial;"
		"temp_file=$temp_file;"
		'if [ ! -z $full_key_line ]; then'
		'key_text=$(echo $full_key_line | cut -d" " -f1);'
		'key_code=$(echo $full_key_line | cut -d" " -f2);'
		'(adb -s $serial shell input keyevent $key_code) &;'
		'echo "   $(date +"%H:%M:%S")\t$key_text\t$key_code" >> $temp_file;'
		'fi;'
		')+refresh-preview'
	)
	bind_commands+=('--bind' "enter:$enter_cmd")

	# Bind: Tab - Clear the query string.
	clear_query=(
		'clear-query'
	)
	bind_commands+=('--bind' "tab:$clear_query")

	# Preview - Show the tmp file that keeps track of what commands have been submitted.
	preview_cmd=("--preview" "cat $temp_file;")
	preview_window=("--preview-window" "right,60%,nohidden,wrap")

	# Bind: Esc - We want to accept here because Esc should return 0 instead of 130.
	bind_commands+=('--bind' "esc:accept")

	# Bind: Ctrl-D - Compatibility with Ctrl-D to escape to command mode.
	bind_commands+=('--bind' "Ctrl-D:accept")

	# Bind: Ctrl-W - Compatibility with Ctrl-D to escape to command mode.
	bind_commands+=('--bind' "Ctrl-W:execute-silent(echo '$MANUAL_WRITE_MODE' > $temp_file_mode;)+accept")

	# Just some pretty defaults for fzf.
	fzf_params=('--exact' '--ansi' '--tac' '--no-sort' '--multi')
	fzf_pretty=('--info' 'inline' '--pointer' '>')
	fzf_header=('--header-first')
	fzf_gui=('--border' '--margin' '0.5%' '--padding' '0.5%' '--height' '30%')

	# Execute the actual fzf instruction.
	echo $KEY_CODES | fzf $fzf_params $fzf_pretty $fzf_header $fzf_gui $bind_commands $preview_cmd $preview_window >/dev/null
	ret=$?

	mode_command=$(cat $temp_file_mode)

	__write_find_mode_output

	command rm "${temp_file}"
	command rm "${temp_file_mode}"

	# If we Ctrl-Ced, make sure we exit amot entirely.
	if [ $ret -eq 130 ]; then
		mode_command=$EXIT_MODE
	fi
}
