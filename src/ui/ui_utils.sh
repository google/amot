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

ansi_bold="\033[1m"
ansi_end="\033[0m"
ansi_red="\033[31m"
ansi_green="\033[32m"
ansi_yellow="\033[33m"

ui_stack=()

__pop_stack() {
	stack_element=${ui_stack[-1]}
	unset 'ui_stack[-1]'

	case $stack_element in
	'single_prompt')
		printf "\33[2K\r"
		printf "\33[1A\33[2K\r"
		;;
	'double_prompt')
		printf "\33[2K\r"
		printf "\33[1A\33[2K\r"
		printf "\33[1A\33[2K\r"
		printf "\33[1A\33[2K\r"
		;;
	'vared_prompt')
		printf "\33[2K\r"
		printf "\33[1A\33[2K\r"
		printf "\33[1A\33[2K\r"
		;;
	'output')
		:
		;;
	esac
}
