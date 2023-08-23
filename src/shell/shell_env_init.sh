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

# Initialize the key map file if required.
key_map_file_name="$HOME/.amot_key_map"

# Initialize the keymap file if it doesn't exist.
if [ ! -f $key_map_file_name ]; then
	touch $key_map_file_name
	echo $KEY_MAP_DEFAULT >>$key_map_file_name
fi

# Print the instruction header per the CLI parameters.
echo -e "$HEADER"
if [[ $instruction_flag == "true" ]]; then
	echo $INSTRUCTIONS
fi

# Make sure we initialize the in-memory keymap before we start.
reload_map="true"
