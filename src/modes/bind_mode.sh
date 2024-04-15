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

__amot_bind_mode() {

	# Get the hex code from the user.
	if ! __amot_get_key_to_bind; then
		return 1
	fi

	__write_formatted_two_line_prompt "${ansi_bold}Bind Mode${ansi_end}" \
		"${ansi_green}$composite_hex_key${ansi_end}" \
		"\\" \
		"${ansi_bold}Key(${ansi_yellow}1${ansi_end}${ansi_bold})${ansi_end}\t" \
		"${ansi_bold}Text(${ansi_yellow}2${ansi_end}${ansi_bold})${ansi_end}\t" \
		"${ansi_bold}Command(${ansi_yellow}3${ansi_end}${ansi_bold})${ansi_end}\t" \
		"${ansi_bold}Ctrl-D(${ansi_yellow}Abort${ansi_end}${ansi_bold})${ansi_end}"

	local key_or_text_bind=""
	read -sk1 key_or_text_bind

	if [[ "$key_or_text_bind" == "2" ]]; then
		__write_formatted_two_line_prompt "${ansi_bold}Bind Mode${ansi_end}" \
			"${ansi_green}$composite_hex_key${ansi_end}" \
			"\\" \
			"${ansi_yellow}Text: ${ansi_end}"

		read bind_text

		__write_formatted_output "$(date +"%H:%M:%S")" \
			"${ansi_bold}Bind${ansi_end}" \
			"${ansi_green}$composite_hex_key${ansi_end}" \
			"${ansi_green}Bound${ansi_end}" \
			"\"$bind_text\""

		binding_string="$composite_hex_key text $bind_text"
	elif [[ "$key_or_text_bind" == "1" ]]; then
		# Get the ADB keycode from the user.
		if ! key_code_bind=$(__amot_select_code); then
			return
		fi

		# Split the adb keycode into key and value.
		local key_msg=$(echo $key_code_bind | cut -d' ' -f1)
		local key_code=$(echo $key_code_bind | cut -d' ' -f2)

		__write_formatted_two_line_prompt "${ansi_bold}Bind Mode${ansi_end}" \
			"${ansi_green}$composite_hex_key${ansi_end}" \
			"${ansi_green}$key_code${ansi_end}" \
			"\\" \
			"${ansi_yellow}Label: ${ansi_end}"

		read key_label_bind

		__write_formatted_output "$(date +"%H:%M:%S")" \
			"${ansi_bold}Bind${ansi_end}" \
			"${ansi_green}$composite_hex_key${ansi_end}" \
			"${ansi_yellow}Bound${ansi_end}" \
			"$key_label_bind"

		binding_string="$composite_hex_key key $key_code $key_label_bind"
	elif [[ "$key_or_text_bind" == "3" ]]; then
		__write_formatted_two_line_prompt "${ansi_bold}Bind Mode${ansi_end}" \
			"${ansi_green}$composite_hex_key${ansi_end}" \
			"\\" \
			"${ansi_yellow}Command: adb -s \$serial shell ${ansi_end}"

		read adb_cmd

		__write_formatted_output "$(date +"%H:%M:%S")" \
			"${ansi_bold}Bind${ansi_end}" \
			"${ansi_green}$composite_hex_key${ansi_end}" \
			"${ansi_green}Bound${ansi_end}" \
			"\"$adb_cmd\""

		binding_string="$composite_hex_key cmd $adb_cmd"
	else
		return
	fi

	# Perform the actual binding.
	echo $binding_string >>$key_map_file_name

	reload_map="true"
}

__amot_get_key_to_bind() {
	local ret=0

	# Print initial header.
	__write_formatted_two_line_prompt "${ansi_bold}Bind Mode${ansi_end}" \
		"\\" \
		"${ansi_green}Press key to bind...${ansi_end}"

	composite_hex_key=$(__amot_read_key_from_input | cut -d' ' -f1)

	if __amot_is_key_reserved $composite_hex_key; then
		return 1
	fi

	if __amot_is_key_abort $composite_hex_key; then
		return 1
	fi

	# If there is an associated key, let's avoid a collision.
	if [ ! -z $KEY_MAP[$composite_hex_key] ]; then
		__write_formatted_two_line_prompt "${ansi_bold}Bind Mode${ansi_end}" \
			"${ansi_green}$composite_hex_key${ansi_end}" \
			"${ansi_yellow}Already Bound!${ansi_end}" \
			"\\" \
			"Unbind:" \
			"y/${ansi_bold}N${ansi_end}"

		if read -sq; then
			# This is required because Mac `sed` is not standard.
			if [ "$(uname)" = "Darwin" ]; then
				sed -i '' "s/$composite_hex_key.*//g" $key_map_file_name
			else
				sed -i "s/$composite_hex_key.*//g" $key_map_file_name
			fi
		else
			local ret=1
		fi
	fi

	return $ret
}
