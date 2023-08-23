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

FIND_MODE="find"
EXIT_MODE="exit"
MANUAL_WRITE_MODE="write_manual"
AUTOMATIC_WRITE_MODE="write_automatic"
BIND_MODE="bind"
UNBIND_MODE="unbind"
COMMAND_MODE="command"

__amot_select_code() {
	# Bind: Enter - Accept.
	enter_cmd=(
		'accept'
	)
	bind_commands+=('--bind' "enter:$enter_cmd")

	# Just some pretty defaults for fzf.
	fzf_params=('--exact' '--ansi' '--tac' '--no-sort' '--multi')
	fzf_pretty=('--info' 'inline' '--pointer' '>')
	fzf_header=('--header-first')
	fzf_gui=('--border' '--margin' '0.5%' '--padding' '0.5%' '--height' '30%')

	# Execute the actual fzf instruction.
	echo $KEY_CODES | fzf $fzf_params $fzf_pretty $fzf_header $fzf_gui $bind_commands $preview_cmd $preview_window
}

__amot_read_key_from_input() {
	# Grab a potentially multi-part key.
	local first_key=""
	read -sk1 first_key
	local composite_hex_key="$(printf %x\\n \'$first_key)"

	local next_key=""
	while read -sk1 -t 0.0001 next_key; do
		local composite_hex_key="$composite_hex_key$(printf %x\\n \'$next_key)"
	done

	if [ -z $next_key ]; then
		echo "$composite_hex_key $first_key"
	else
		echo "$composite_hex_key"
	fi
}

__amot_is_key_reserved() {
	composite_hex_key=$1

	# Reserved: Ctrl-B, Ctrl-W, Tab, Delete.
	RESERVED_KEYS=("2" "17" "9" "1b5b337e")
	if (( $RESERVED_KEYS[(Ie)$composite_hex_key] )); then
		__write_formatted_output \
		"$(date +"%H:%M:%S")"\
		"${ansi_bold}Bind${ansi_end}"\
		"${ansi_green}$composite_hex_key${ansi_end}"\
		"${ansi_red}Cannot Rebind${ansi_end}"
		return 0
	fi

	return 1
}

__amot_is_key_abort(){
	composite_hex_key=$1

	# Check if we are exiting through Ctrl-D.
	if [[ $composite_hex_key == "4" ]]; then
		__write_formatted_output\
		"$(date +"%H:%M:%S")"\
		"${ansi_bold}Bind${ansi_end}"\
		"${ansi_red}ABORTING${ansi_end}"
		return 0
	fi

	return 1
}
