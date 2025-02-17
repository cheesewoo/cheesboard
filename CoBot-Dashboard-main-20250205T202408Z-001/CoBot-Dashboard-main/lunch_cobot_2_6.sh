#!/bin/bash

echo "Starting COBOT calibration..."

cd ..
cd ..
cd ..
cd ..

python3 - <<EOF
import importlib.util
import time

script_path = "cobot-ws/src/configuration/ar3-bringup/scripts/test.py"
spec = importlib.util.spec_from_file_location("test", script_path)
test = importlib.util.module_from_spec(spec)
spec.loader.exec_module(test)

test.init(7)
test.calibrate(0b111111)

time.sleep(60)
EOF

python3 - <<EOF
import importlib.util 

script_path = "cobot-ws/src/configuration/ar3-bringup/scripts/test.py"
spec = importlib.util.spec_from_file_location("test", script_path)
test = importlib.util.module_from_spec(spec)
spec.loader.exec_module(test)

test.home(0b111111)
EOF

echo "COBOT calibration completed successfully."

echo "Connecting to Raspberry Pi..."
ssh cobot0@cobot0.local <<EOF
cd cobot-raspi-ws
source install/setup.bash
ros2 launch bringup generic.launch.xml
EOF

echo "Starting ROS2 Showcase Demo..."
cd ~/cobot-ws
source install/setup.bash
ros2 launch ar3_bringup demo.launch.py &

sleep 5

echo "Starting Servo service..."
gnome-terminal -- bash -c 'source ~/cobot-ws/install/setup.bash && rqt'

sleep 5

echo "Launching Topic Tester..."
gnome-terminal -- bash -c 'cd ~/cobot-ws && source install/setup.bash && ros2 run topic_tester topic_tester'

sleep 2

echo "Setting COBOT speed and Stockfish timer..."
echo "set s 1" | ros2 run topic_tester topic_tester
echo "set w 1000" | ros2 run topic_tester topic_tester

echo "Starting COBOT game..."
echo "set e 1" | ros2 run topic_tester topic_tester

echo "COBOT system started."
exit 0
