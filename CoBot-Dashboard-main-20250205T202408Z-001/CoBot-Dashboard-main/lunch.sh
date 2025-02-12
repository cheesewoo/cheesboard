#!/bin/bash



echo "start calibrating"

cd ~/cobot-ws

python3 <<EOF

print("233")
from src.configuration.ar3-bringup.scripts.test import init, calibrate, home
init(7)
calibrate(0b111111)
EOF

sleep 60

python3 <<EOF
from src.configuration.ar3-bringup.scripts.test import home
home(0b111111)
EOF

exit





