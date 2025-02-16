#!/bin/bash

echo "Starting COBOT calibration..."

cd ~/cobot-ws || { echo "Error: Could not enter workspace directory"; exit 1; }

# Run initialization and calibration
python3 <<EOF
import importlib.util

script_path = "src/configuration/ar3-bringup/scripts/test.py"
spec = importlib.util.spec_from_file_location("test", script_path)
test = importlib.util.module_from_spec(spec)
spec.loader.exec_module(test)

print("Initializing COBOT...")
test.init(7)
print("Calibrating joints...")
test.calibrate(0b111111)
EOF

# Wait to simulate calibration time
sleep 60  

# Run homing
python3 <<EOF
import importlib.util

script_path = "src/configuration/ar3-bringup/scripts/test.py"
spec = importlib.util.spec_from_file_location("test", script_path)
test = importlib.util.module_from_spec(spec)
spec.loader.exec_module(test)

print("Homing joints...")
test.home(0b111111)
EOF

echo "COBOT calibration completed successfully."
exit 0

