import subprocess
import time

def run_command(command, shell=True):
    process = subprocess.Popen(command, shell=shell, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = process.communicate()
    return out.decode(), err.decode()

def open_new_terminal_w_command(command):
    subprocess.Popen(['gmone-terminal', '--', 'bash', '-c', command])
    #install terminal gnome 

def calibrate_chess_bot():
    print("Calibraring Chess Bot...\n")
    print("Changing directory to cobot-ws...\n")
    run_command('cd cobot-ws')
    print("Opening Calibration Script...\n")
    run_command('python3 src/configuration/ar3-bringup/scripts/test.py')
    print("initializing.../n")
    out, err = run_command('echo "calibrate(0b111111)" | python3 src/configuration/ar3-bringup/scripts/test.py', shell=False)
    print("waiting for calibration to complete...\n")
    time.sleep(60) # adjust time later 
    print("sending home...\n")
    out, err = run_command('echo "home(0b111111)" | python3 src/configuration/ar3-bringup/scripts/test.py', shell=False)
    print(out)
    print("exiting calibration...\n")
    out, err = run_command('echo "exit" | python3 src/configuration/ar3-bringup/scripts/test.py', shell=False)
    print(out)

def start_raspberry_pi(): 
    print("starting raspberry pi...\n")
    print("ssh into cobot0@cobot0.local")
    run_command('ssh cobot0@cobot0.local')
    time.sleep(30); #pause to get password?
    #line to enter password?
    print("changing directory to cobot-raspi-ws")
    run_command('cd cobot-raspi-ws')
    print("sourcing ROS2 workspace...\n")
    run_command('source install/setup.bash')
    print("launching TOF interface...\n")
    out, err = run_command('ros2 launch bringup generic.launch.xml')
    print(out)

def launch_showcase_demo(): 
    print("launching RVIZ...\n")
    open_new_terminal_w_command('cd ../cobot-ws')
    run_command('source install/setup.bash')
    run_command('ros2 launch ar3_bringup demo.launch.py')
    print("starting servo...\n")
    open_new_terminal_w_command('cd ../cobot-ws')
    run_command('ros2 service call /servo_node/start_servo std_srvs/srv/Trigger')#this may change 
    #/servo_node/start_servo std_srvs/srv/Trigger

if __name__ == "__main__":
    calibrate_chess_bot()
    start_raspberry_pi()
    launch_showcase_demo()