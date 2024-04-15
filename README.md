# amot (Android Remote)

### Introduction
amot is a zsh CLI tool for controlling an Android device through key inputs. It provides a configurable TUI on top of ADB that allows custom bindings for command, keycode, and text input. Keycodes and text can be submitted freeform or bound to keys to automatically execute.

### Motivation
There are many ways to control Android devices from an ADB-attached device, but all the solutions I've found are heavy-weight and missing critical features. amot strives to be lightweight, portable (within zsh, at least), and easily configurable for any specific use-case.

Out of the box, amot provides some reasonable defaults you may want to use for navigation, and automatically recognizes attempts to input text.

https://github.com/google/amot/assets/126256142/a7944a83-5cc0-495a-9c62-631689e95326

But those are just defaults. You can bind any key to a keycode or string.

https://github.com/google/amot/assets/126256142/63ae62e1-9681-452d-b930-fc2d9fbef553

amot even provides the capability to bind arbitrary adb shell commands.

https://github.com/google/amot/assets/126256142/76b0a86e-2eb7-4cd9-ba0c-990228d7cccf

As you bind the keys and assign the commands you use most frequently, amot becomes a control panel for Android that you can flick open and seamlessly execute complex strings of commands.

https://github.com/google/amot/assets/126256142/e2430432-c83e-4cc1-be19-1fcc5b352906

### Dependencies

`amot` currently functions on Ubuntu Linux and Mac on zsh. It requires a local installation of `fzf` and `adb`.

Support for Windows may be provided in future, but is not a current priority.

### Installation
1. Download the latest release version.
2. Place the script in your PATH.

### Compilation
1. Clone the repo.
2. Run `make`.

### Guide
`amot` includes a simple tool to help select the device serial from `adb devices`, or can read from the `$ANDROID_SERIAL` environment variable if set. Otherwise, `amot` has two command-line parameters:

#### Instructions
* -i: Do not show any instructions.

#### Debug Commands
* -v: Shows the `amot` version.

Any other command-line parameters will print the help dialog.

### Modes

#### Command Mode
By default, amot starts in command mode. Pressing any key in this mode will execute the binding on that key if it exists, or enter write mode if the key is a unbound text key.

#### Bind/Unbind Mode
To add a new binding to Command mode, you can use Ctrl-B to enter bind mode. You can bind an ADB command, keycode, or text input to any non-reserved key.

You can also use Delete to enter unbind mode and unbind a specific key.

#### Find Mode
Find mode allows arbitrary adb code input, selected from a menu of codes. This is powered by `fzf` fuzzy-searching.

#### Write Mode
Write mode allows text input through adb. It automatically escapes any character adb requires to be escaped, such as spaces and quotes.

### Development
1. Clone the repo
2. Open in your favorite IDE/editor

### Dependencies
* [fzf](https://github.com/junegunn/fzf)
* [zsh](https://github.com/zsh-users/zsh)
* [adb](https://developer.android.com/studio/command-line/adb)

### Support

If you've found an error, please file an issue:

https://github.com/google/amot/issues

Patches are encouraged, and may be submitted by forking this project and
submitting a pull request through GitHub.

License
=======

    Copyright 2023 Google LLC

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
