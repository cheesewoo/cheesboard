#!/bin/bash

gnome-terminal -- bash -c "
cd /path/to/cobot-ws &&
source install/setup.bash &&
ros2 run topic_tester topic_tester &&
echo 'set s 1' &&
echo 'set w 1000' &&
exec bash
"
