#!/bin/bash

# Ensure emulator is ready 
sleep 15
adb shell input keyevent 4
            
# Start recording
mkdir captures
adb shell screenrecord /sdcard/recording.mp4 &
PID=$!
echo $PID

# Download app
curl -X GET -o "app.apk" "https://firebasestorage.googleapis.com/v0/b/nilsreichardt.appspot.com/o/mobile_scanner%2Fapp-release-2.apk?alt=media&token=3ff4fe70-3d23-4c7e-9849-edd622e7f7f1"

# Install app
adb install app.apk

# Grant permission
adb shell pm grant dev.steenbakker.mobile_scanner_example android.permission.CAMERA

# Open app
adb shell am start -n dev.steenbakker.mobile_scanner_example/io.flutter.embedding.android.FlutterActivity

# Make screenshots
sleep 10
adb shell screencap -p > captures/1.jpg

# Stop recording
kill $PID
sleep 1
adb pull /sdcard/recording.mp4 ./captures
