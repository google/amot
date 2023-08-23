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

KEY_MAP_DEFAULT=$(
	cat <<-END
		7f key 67 Delete
		a key 66 Enter
		1b5b41 key 19 Up Arrow
		1b5b42 key 20 Down Arrow
		1b5b44 key 21 Left Arrow
		1b5b43 key 22 Right Arrow
		1b4f50 key 3 F1 - Home
		1b4f51 key 176 F2 - Settings
		1b4f52 key 219 F3 - Assistant
		1b4f53 key 164 F4 - Toggle Mute
		1b key 4 Back
	END
)
