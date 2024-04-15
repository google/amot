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

__amot_unbind_mode() {

	# Print initial header.
	__write_formatted_prompt "${ansi_bold}Unbind Mode${ansi_end}" \
		"${ansi_green}Press key to unbind...${ansi_end}"

	composite_hex_key=$(__amot_read_key_from_input | cut -d' ' -f1)

	if __amot_is_key_reserved $composite_hex_key; then
		return 1
	fi

	if __amot_is_key_abort $composite_hex_key; then
		return 1
	fi

	if [ -z $KEY_MAP[$composite_hex_key] ]; then
		__write_formatted_output "$(date +"%H:%M:%S")" \
			"${ansi_bold}Unbind${ansi_end}" \
			"${ansi_green}$composite_hex_key${ansi_end}" \
			"${ansi_green}NOT BOUND${ansi_end}"
		return 1
	fi

	__write_formatted_prompt "${ansi_bold}Unbind Mode${ansi_end}" \
		"${ansi_green}Hex - $composite_hex_key${ansi_end}" \
		"${ansi_green}y${ansi_end}/${ansi_red}N${ansi_end}"

	if read -sq; then
		__write_formatted_output "$(date +"%H:%M:%S")" \
			"${ansi_bold}Unbind${ansi_end}" \
			"${ansi_green}$composite_hex_key${ansi_end}" \
			"${ansi_yellow}UNBOUND${ansi_end}"

		# This is required because Mac `sed` is not standard.
		if [ "$(uname)" = "Darwin" ]; then
			sed -i '' "s/$composite_hex_key.*//g" $key_map_file_name
		else
			sed -i "s/$composite_hex_key.*//g" $key_map_file_name
		fi
	else
		__write_formatted_output "$(date +"%H:%M:%S")" \
			"${ansi_bold}Unbind${ansi_end}" \
			"${ansi_green}$composite_hex_key${ansi_end}" \
			"${ansi_red}ABORTED${ansi_end}"

		return 1
	fi

	reload_map="true"
}
