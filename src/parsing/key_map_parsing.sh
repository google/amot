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

__amot_initialize_key_map() {

	# Read each line of the key map.
	while read -r line; do

		# Split into key/value pair.
		map_key=$(echo $line | cut -d' ' -f1)
		map_value=$(echo $line | cut -d' ' -f2-)

		# Check if the key is hex-code.
		if ! ((16#$map_key)) &>/dev/null && [ ! -z $map_key ]; then
			echo "Ran into non-hex $map_key when initializing key map!"
			echo "Please specify the first word in each column as hex!"
			echo "Line: $line"
			exit 1
		fi

		# Check that the adb code is valid.
		map_type=$(echo $line | cut -d' ' -f2)
		map_adb_code=$(echo $line | cut -d' ' -f3)

		# Validate key and text input to make sure the map is not corrupted.
		if [[ $map_type == "key" ]]; then
			if ! [[ $map_adb_code =~ '^[0-9]+$' ]] &>/dev/null && [ ! -z $map_adb_code ]; then
				echo "Ran into non-integer $map_adb_code when initializing key map!"
				echo "Please specify the third word in each key column as integer!"
				echo "Line: $line"
				echo "If you didn't meddle with $key_map_file_name, report me as a bug!"
				exit 1
			fi
		elif [[ $map_type != "text" ]] && [[ $map_type != "cmd" ]]  && [ ! -z $map_type ]; then
			echo "Ran into invalid type $map_type when initializing key map!"
			echo "Please specify the second word in each column as one of 'cmd', 'key', or 'text'!"
			echo "Line: $line"
			echo "If you didn't meddle with $key_map_file_name, report me as a bug!"
			exit 1
		fi

		# Place the value into the hash map.
		KEY_MAP[$map_key]="$map_value"
	done <$key_map_file_name

	# Keep the file human readable.
	sort -o $key_map_file_name $key_map_file_name
	sed -i '/^$/d' $key_map_file_name
}
