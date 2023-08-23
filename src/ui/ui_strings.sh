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

VERSION="1.0.0"

HEADER=$(
	cat <<-END
		${ansi_bold}AMOT: Android Remote${ansi_end}
		————————————————————
	END
)

INSTRUCTIONS=$(
	cat <<-END
		   ${ansi_bold}Command Mode${ansi_end}\tCtrl-D
		   \tBind commands using Bind Mode. Default bindings are below:

		   \tEnter - Accept, Esc - Back, Backspace - Delete, Arrows Keys - DPAD
		   \tF1 - Home Key, F2 - Settings Key, F3 - Assistant Key, F4 - Toggle Mute
		   ——————————
		   ${ansi_bold}Bind Mode${ansi_end}\tCtrl-B
		   \tFollow on-screen instructions.
		   ——————————
		   ${ansi_bold}Find Mode${ansi_end}\tTab key
		   \tType to search, Tab to clear, Enter to submit, Escape or Ctrl-D to exit
		   ——————————
		   ${ansi_bold}Unbind Mode${ansi_end}\tDelete key
		   \tFollow on-screen instructions.
		   ——————————
		   ${ansi_bold}Write Mode${ansi_end}\tCtrl-W or any unbound ASCII key
		   \tType and press Enter to submit to the device.
		————————————————————
	END
)

usage=$(
	cat <<-END
		amot - Android Remote TUI to support Android keyboard input.
		\t[-i: Start without instructions.]
		\t[-v: Get version number]
	END
)
