import os
from ctypes import cdll

lib = None
if os.path.exists("../MotorControl/libmotor.so"):
    lib = cdll.LoadLibrary("../MotorControl/libmotor.so")           # For docker
elif os.path.exists("../../../MotorControl/libmotor.so"):
    lib = cdll.LoadLibrary("../../../MotorControl/libmotor.so")     # For local testing if running motor.py in it's own directory
elif os.path.exists("./MotorControl/libmotor.so"):
    lib = cdll.LoadLibrary("./MotorControl/libmotor.so")            # For running locally via start.sh

class Motor:
    def __init__(self):
        self.obj = lib.Motor_new()

    def status(self) -> bool:
        return True if lib.Motor_status(self.obj) == 1 else False

    def get_current_percent(self) -> int:
        return lib.Motor_currentPercent(self.obj)

    def open(self) -> None:
        lib.Motor_open(self.obj)

    def close(self) -> None:
        lib.Motor_close(self.obj)
    
    def move_to_percent(self, percent) -> None:
        lib.Motor_moveToPercent(self.obj, percent)
