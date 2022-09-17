#!/usr/bin/env bash

# v4l2-ctlの参考ページ
# https://www.prototype00.com/2021/11/v4l2-ctl-usbcam.html

set -e

if [ $# -eq 0 ]; then
    echo "引数にカメラデバイス名を設定してください"
    echo "e.g. ./camera_settings.sh /dev/video0"
fi

CAMERA=$1

# 輝度を設定する
# brightness: min=-64 max=64 step=1 default=10 value=10
v4l2-ctl -d $CAMERA -c brightness=10
sleep 0.05

# コントラストを設定する
# contrast: min=0 max=64 step=1 default=40 value=40
v4l2-ctl -d $CAMERA -c contrast=40
sleep 0.05

# 彩度を設定する
# saturation: min=0 max=128 step=1 default=76 value=76
v4l2-ctl -d $CAMERA -c saturation=100
sleep 0.05

# ゲインを設定する
# gain: min=0 max=100 step=1 default=0 value=0
v4l2-ctl -d $CAMERA -c gain=0
sleep 0.05

# フリッカー(ちらつき)対策用の電源周波数設定を設定する(0:無効 1:50Hz 2:60Hz)
# power_line_frequency: min=0 max=2 default=1 value=1 (50 Hz)
v4l2-ctl -d $CAMERA -c power_line_frequency=1
sleep 0.05

# 自動ホワイトバランス機能を無効に設定する(1:有効  0:無効)
# white_balance_temperature_auto: default=1 value=1
v4l2-ctl -d $CAMERA -c white_balance_temperature_auto=0
sleep 0.05

# ホワイトバランスを設定する
# white_balance_temperature: min=2800 max=6500 step=1 default=4600 value=4600 flags=inactive
v4l2-ctl -d $CAMERA -c white_balance_temperature=4600
sleep 0.05

# シャープネスを設定する
# sharpness: min=0 max=6 step=1 default=0 value=0
v4l2-ctl -d $CAMERA -c sharpness=0
sleep 0.05

# バックライト補正を設定する(1:有効 0:無効)
# backlight_compensation 0x0098091c (int)    : min=0 max=2 step=1 default=1 value=1
v4l2-ctl -d $CAMERA -c backlight_compensation=1
sleep 0.05

# 自動露光の設定（1:手動モード、3:絞り優先モード)
# exposure_auto: min=0 max=3 default=3 value=3 (Aperture Priority Mode)
v4l2-ctl -d $CAMERA -c exposure_auto=1
sleep 0.05

# 露光時間を設定する(単位ms: 例:2000ms=2秒)
# exposure_absolute: min=1 max=5000 step=1 default=156 value=156 flags=inactive
v4l2-ctl -d $CAMERA -c exposure_absolute=500
sleep 0.05

# 自動露出優先制御を設定する(1:自動 0:手動)
# 事前に自動露出モードを手動以外(絞り優先等)にしておく
# (このモードの使い方はよく分かっていない)
# exposure_auto_priority: default=0 value=1
v4l2-ctl -d $CAMERA -c exposure_auto_priority=0
sleep 0.05

# 以下は割愛
# pan_absolute : カメラを水平方向に回転させる
# pan_absolute : min=-36000 max=36000 step=3600 default=0 value=0
# tilt_absolute : カメラを垂直方向に回転させる
# tilt_absolute : min=-36000 max=36000 step=3600 default=0 value=0
# zoom_absolute : ズーム設定
# zoom_absolute : min=0 max=9 step=1 default=0 value=0
# hue 0x00980903 (int)    : min=-40 max=40 step=1 default=0 value=0
# gamma 0x00980910 (int)    : min=72 max=500 step=1 default=100 value=100

# フレームレート設定
v4l2-ctl -d $CAMERA -p 30
sleep 0.05

