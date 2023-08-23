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

while true; do
	swap_mode_command="$mode_command"
	mode_command=""

	# If we've changed a binding, we want to rebind the map. We can't do this
	# every loop because IO is pretty expensive.
	if [[ $reload_map == "true" ]]; then

		# Clear the existing key map.
		KEY_MAP=""
		declare -A KEY_MAP

		__amot_initialize_key_map
		reload_map="false"
	fi

	if [[ $swap_mode_command == $FIND_MODE ]]; then
		__amot_find_mode
	elif [[ $swap_mode_command == $EXIT_MODE ]]; then
		return 130
	elif [[ $swap_mode_command == $MANUAL_WRITE_MODE ]]; then
		__amot_write_mode "$MANUAL_WRITE_MODE"
	elif [[ $swap_mode_command == $AUTOMATIC_WRITE_MODE ]]; then
		__amot_write_mode "$AUTOMATIC_WRITE_MODE"
	elif [[ $swap_mode_command == $BIND_MODE ]]; then
		__amot_bind_mode
	elif [[ $swap_mode_command == $UNBIND_MODE ]]; then
		__amot_unbind_mode
	else
		__amot_command_mode
	fi
done
