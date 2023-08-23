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

__amot_command_mode() {
	while [ -z $mode_command ]; do
		__write_formatted_prompt "${ansi_bold}Cmd Mode${ansi_end}" \
			"${ansi_green}Awaiting input...${ansi_end}"

		local key_input=$(__amot_read_key_from_input)
		local composite_hex_key=$(echo $key_input | cut -d' ' -f1)

		# Special UI key code.
		if [[ $composite_hex_key == "17" ]]; then # Ctrl-W
			mode_command=$MANUAL_WRITE_MODE
		elif [[ $composite_hex_key == "9" ]]; then # Tab
			mode_command=$FIND_MODE
		elif [[ $composite_hex_key == "2" ]]; then # Ctrl-B
			mode_command=$BIND_MODE
		elif [[ $composite_hex_key == "1b5b337e" ]]; then # Delete
			mode_command=$UNBIND_MODE
		elif [[ $composite_hex_key == "4" ]]; then # Ctrl-D
			mode_command=$COMMAND_MODE
		else

			# Grab the associated key from the has map.
			local key_map_entry=$KEY_MAP[$composite_hex_key]

			# If there is no associated key, check if we need to enter write mode.
			if [ -z $key_map_entry ]; then

				# If it's a multi-part key, we shouldn't switch to write mode.
				local first_key=$(echo $key_input | cut -d' ' -f2-)
				if [[ "$first_key" != "$composite_hex_key" ]]; then
					__write_formatted_output "${ansi_yellow}Switching to write mode${ansi_end}"
					write_mode_input="$first_key"
					mode_command=$MANUAL_WRITE_MODE
				else
					__write_formatted_output "$(date +"%H:%M:%S")" \
						"'$composite_hex_key' Unbound"
					__write_formatted_output "${ansi_yellow}Press Ctrl-B to bind a new key!${ansi_end}"
				fi
			else

				# Split the code and instruction to be printed seperately.
				key_type=$(echo $key_map_entry | cut -d' ' -f1)

				if [[ $key_type == "key" ]]; then
					key_code=$(echo $key_map_entry | cut -d' ' -f2)
					key_instruction=$(echo $key_map_entry | cut -d' ' -f3-)

					# Send the key command.
					__write_formatted_output "$(date +"%H:%M:%S")" \
						"$key_instruction" \
						"$key_code"

					(adb &>/dev/null -s $serial shell input keyevent $key_code &)
				elif [[ $key_type == "text" ]]; then
					key_text=$(echo $key_map_entry | cut -d' ' -f2-)

					write_mode_input="$key_text"
					mode_command=$AUTOMATIC_WRITE_MODE
				elif [[ $key_type == "cmd" ]]; then
					adb_cmd="adb -s $serial shell $(echo $key_map_entry | cut -d' ' -f2-)"

					# Send the key command.
					__write_formatted_output "$(date +"%H:%M:%S")" \
						"Executed:" "$adb_cmd"
					
					eval ${adb_cmd}
				fi
			fi
		fi
	done
}
