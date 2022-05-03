#!/bin/bash

# Ensure emulator is ready 
sleep 15
adb shell input keyevent 4
            
# Start recording
mkdir captures
adb shell screenrecord /sdcard/recording.mp4 &
PID=$!
echo $PID

# Install app
adb install example/app-release.apk

# Grant permission
adb shell pm grant com.example.example android.permission.CAMERA
adb shell pm grant com.example.example android.permission.RECORD_AUDIO

# Open app
adb shell am start -n com.example.example/io.flutter.embedding.android.FlutterActivity

# Make screenshots
sleep 10
adb shell screencap -p > captures/1.jpg

# Stop recording
kill $PID
sleep 1
adb pull /sdcard/recording.mp4 ./captures
