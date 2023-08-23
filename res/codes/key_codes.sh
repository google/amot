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

KEY_CODES=$(
	cat <<-END
		keycode_unknown 0
		keycode_soft_left 1
		keycode_soft_right 2
		keycode_home 3
		keycode_back 4
		keycode_call 5
		keycode_endcall 6
		keycode_0 7
		keycode_1 8
		keycode_2 9
		keycode_3 10
		keycode_4 11
		keycode_5 12
		keycode_6 13
		keycode_7 14
		keycode_8 15
		keycode_9 16
		keycode_star 17
		keycode_pound 18
		keycode_dpad_up 19
		keycode_dpad_down 20
		keycode_dpad_left 21
		keycode_dpad_right 22
		keycode_dpad_center 23
		keycode_volume_up 24
		keycode_volume_down 25
		keycode_power 26
		keycode_camera 27
		keycode_clear 28
		keycode_a 29
		keycode_b 30
		keycode_c 31
		keycode_d 32
		keycode_e 33
		keycode_f 34
		keycode_g 35
		keycode_h 36
		keycode_i 37
		keycode_j 38
		keycode_k 39
		keycode_l 40
		keycode_m 41
		keycode_n 42
		keycode_o 43
		keycode_p 44
		keycode_q 45
		keycode_r 46
		keycode_s 47
		keycode_t 48
		keycode_u 49
		keycode_v 50
		keycode_w 51
		keycode_x 52
		keycode_y 53
		keycode_z 54
		keycode_comma 55
		keycode_period 56
		keycode_alt_left 57
		keycode_alt_right 58
		keycode_shift_left 59
		keycode_shift_right 60
		keycode_tab 61
		keycode_space 62
		keycode_sym 63
		keycode_explorer 64
		keycode_envelope 65
		keycode_enter 66
		keycode_del 67
		keycode_grave 68
		keycode_minus 69
		keycode_equals 70
		keycode_left_bracket 71
		keycode_right_bracket 72
		keycode_backslash 73
		keycode_semicolon 74
		keycode_apostrophe 75
		keycode_slash 76
		keycode_at 77
		keycode_num 78
		keycode_headsethook 79
		keycode_plus 81
		keycode_menu 82
		keycode_notification 83
		keycode_search 84
		keycode_media_play_pause 85
		keycode_media_stop 86
		keycode_media_next 87
		keycode_media_previous 88
		keycode_media_rewind 89
		keycode_media_fast_forward 90
		keycode_mute 91
		keycode_page_up 92
		keycode_page_down 93
		keycode_pictsymbols 94
		keycode_switch_charset 95
		keycode_button_a 96
		keycode_button_b 97
		keycode_button_c 98
		keycode_button_x 99
		keycode_button_y 100
		keycode_button_z 101
		keycode_button_l1 102
		keycode_button_r1 103
		keycode_button_l2 104
		keycode_button_r2 105
		keycode_button_thumbl 106
		keycode_button_thumbr 107
		keycode_button_start 108
		keycode_button_select 109
		keycode_button_mode 110
		keycode_escape 111
		keycode_forward_del 112
		keycode_ctrl_left 113
		keycode_ctrl_right 114
		keycode_caps_lock 115
		keycode_scroll_lock 116
		keycode_meta_left 117
		keycode_meta_right 118
		keycode_function 119
		keycode_sysrq 120
		keycode_break 121
		keycode_move_home 122
		keycode_move_end 123
		keycode_insert 124
		keycode_forward 125
		keycode_media_play 126
		keycode_media_pause 127
		keycode_media_close 128
		keycode_media_eject 129
		keycode_media_record 130
		keycode_f1 131
		keycode_f2 132
		keycode_f3 133
		keycode_f4 134
		keycode_f5 135
		keycode_f6 136
		keycode_f7 137
		keycode_f8 138
		keycode_f9 139
		keycode_f10 140
		keycode_f11 141
		keycode_f12 142
		keycode_num_lock 143
		keycode_numpad_0 144
		keycode_numpad_1 145
		keycode_numpad_2 146
		keycode_numpad_3 147
		keycode_numpad_4 148
		keycode_numpad_5 149
		keycode_numpad_6 150
		keycode_numpad_7 151
		keycode_numpad_8 152
		keycode_numpad_9 153
		keycode_numpad_divide 154
		keycode_numpad_multiply 155
		keycode_numpad_subtract 156
		keycode_numpad_add 157
		keycode_numpad_dot 158
		keycode_numpad_comma 159
		keycode_numpad_enter 160
		keycode_numpad_equals 161
		keycode_numpad_left_paren 162
		keycode_numpad_right_paren 163
		keycode_volume_mute 164
		keycode_info 165
		keycode_channel_up 166
		keycode_channel_down 167
		keycode_zoom_in 168
		keycode_zoom_out 169
		keycode_tv 170
		keycode_window 171
		keycode_guide 172
		keycode_dvr 173
		keycode_bookmark 174
		keycode_captions 175
		keycode_settings 176
		keycode_tv_power 177
		keycode_tv_input 178
		keycode_stb_power 179
		keycode_stb_input 180
		keycode_avr_power 181
		keycode_avr_input 182
		keycode_prog_red 183
		keycode_prog_green 184
		keycode_prog_yellow 185
		keycode_prog_blue 186
		keycode_app_switch 187
		keycode_button_1 188
		keycode_button_2 189
		keycode_button_3 190
		keycode_button_4 191
		keycode_button_5 192
		keycode_button_6 193
		keycode_button_7 194
		keycode_button_8 195
		keycode_button_9 196
		keycode_button_10 197
		keycode_button_11 198
		keycode_button_12 199
		keycode_button_13 200
		keycode_button_14 201
		keycode_button_15 202
		keycode_button_16 203
		keycode_language_switch 204
		keycode_manner_mode 205
		keycode_3d_mode 206
		keycode_contacts 207
		keycode_calendar 208
		keycode_music 209
		keycode_calculator 210
		keycode_zenkaku_hankaku 211
		keycode_eisu 212
		keycode_muhenkan 213
		keycode_henkan 214
		keycode_katakana_hiragana 215
		keycode_yen 216
		keycode_ro 217
		keycode_kana 218
		keycode_assist 219
		keycode_brightness_down 220
		keycode_brightness_up 221
		keycode_media_audio_track 222
		keycode_sleep 223
		keycode_wakeup 224
		keycode_pairing 225
		keycode_media_top_menu 226
		keycode_11 227
		keycode_12 228
		keycode_last_channel 229
		keycode_tv_data_service 230
		keycode_voice_assist 231
		keycode_tv_radio_service 232
		keycode_tv_teletext 233
		keycode_tv_number_entry 234
		keycode_tv_terrestrial_analog 235
		keycode_tv_terrestrial_digital 236
		keycode_tv_satellite 237
		keycode_tv_satellite_bs 238
		keycode_tv_satellite_cs 239
		keycode_tv_satellite_service 240
		keycode_tv_network 241
		keycode_tv_antenna_cable 242
		keycode_tv_input_hdmi_1 243
		keycode_tv_input_hdmi_2 244
		keycode_tv_input_hdmi_3 245
		keycode_tv_input_hdmi_4 246
		keycode_tv_input_composite_1 247
		keycode_tv_input_composite_2 248
		keycode_tv_input_component_1 249
		keycode_tv_input_component_2 250
		keycode_tv_input_vga_1 251
		keycode_tv_audio_description 252
		keycode_tv_audio_description_mix_up 253
		keycode_tv_audio_description_mix_down 254
		keycode_tv_zoom_mode 255
		keycode_tv_contents_menu 256
		keycode_tv_media_context_menu 257
		keycode_tv_timer_programming 258
		keycode_help 259
		keycode_navigate_previous 260
		keycode_navigate_next 261
		keycode_navigate_in 262
		keycode_navigate_out 263
		keycode_stem_primary 264
		keycode_stem_1 265
		keycode_stem_2 266
		keycode_stem_3 267
		keycode_dpad_up_left 268
		keycode_dpad_down_left 269
		keycode_dpad_up_right 270
		keycode_dpad_down_right 271
		keycode_media_skip_forward 272
		keycode_media_skip_backward 273
		keycode_media_step_forward 274
		keycode_media_step_backward 275
		keycode_soft_sleep 276
		keycode_cut 277
		keycode_copy 278
		keycode_paste 279
		keycode_system_navigation_up 280
		keycode_system_navigation_down 281
		keycode_system_navigation_left 282
		keycode_system_navigation_right 283
		keycode_all_apps 284
		keycode_refresh 285
		keycode_thumbs_up 286
		keycode_thumbs_down 287
		keycode_profile_switch 288
		keycode_video_app_1 289
		keycode_video_app_2 290
		keycode_video_app_3 291
		keycode_video_app_4 292
		keycode_video_app_5 293
		keycode_video_app_6 294
		keycode_video_app_7 295
		keycode_video_app_8 296
		keycode_featured_app_1 297
		keycode_featured_app_2 298
		keycode_featured_app_3 299
		keycode_featured_app_4 300
		keycode_demo_app_1 301
		keycode_demo_app_2 302
		keycode_demo_app_3 303
		keycode_demo_app_4 304
		keycode_keyboard_backlight_down 305
		keycode_keyboard_backlight_up 306
		keycode_keyboard_backlight_toggle 307
		keycode_stylus_button_primary 308
		keycode_stylus_button_secondary 309
		keycode_stylus_button_tertiary 310
		keycode_stylus_button_tail 311
		keycode_recent_apps 312
		keycode_macro_1 313
		keycode_macro_2 314
		keycode_macro_3 315
		keycode_macro_4 316
	END
)