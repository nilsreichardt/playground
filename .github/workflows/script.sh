#!/bin/bash

# Ensure emulator is ready 
sleep 5
            
# Start recording
mkdir captures
adb shell screenrecord /sdcard/recording.mp4 &
PID=$!
echo $PID

# Grant camera & location permission
adb shell pm grant com.android.camera2 android.permission.ACCESS_COARSE_LOCATION

# Open camera
adb shell am start -a android.media.action.STILL_IMAGE_CAMERA

# Click next on welcome screen
sleep 3
adb shell input keyevent 61
sleep 1
adb shell input keyevent 61
sleep 1
adb shell input keyevent 66

# Make screenshots
sleep 10
adb shell screencap -p > captures/1.jpg

# Stop recording
kill $RECORD_PID
sleep 1
adb pull /sdcard/recording.mp4 ./captures
