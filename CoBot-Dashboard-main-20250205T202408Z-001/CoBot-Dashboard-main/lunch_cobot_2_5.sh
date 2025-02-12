#!/bin/bash

echo "Starting COBOT calibration..."


cd ..
cd ..
cd ..
cd ..



python3 - <<EOF
import io
import sys

sys.stdin = io.StringIO("init(7)\ncalibrate(0b111111)\nexit\n")

import importlib.util
script_path = "cobot-ws/src/configuration/ar3-bringup/scripts/test.py"
spec = importlib.util.spec_from_file_location("test", script_path)
test = importlib.util.module_from_spec(spec)
spec.loader.exec_module(test)
EOF


sleep 60  


python3 - <<EOF
import io
import sys
sys.stdin = io.StringIO("home(0b111111)\nexit\n")

import importlib.util
script_path = "cobot-ws/src/configuration/ar3-bringup/scripts/test.py"
spec = importlib.util.spec_from_file_location("test", script_path)
test = importlib.util.module_from_spec(spec)
spec.loader.exec_module(test)
EOF

echo "COBOT calibration completed successfully."
exit 0


