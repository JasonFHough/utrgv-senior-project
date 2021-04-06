from ctypes import cdll


"""
../
    ['sys', 'home', 'mnt', 'opt', 'boot', 'lib64', 'proc', 'etc', 'srv', 'bin', 'media', 'usr', 'dev', 'lib', 'sbin', 'run', 'root', 'tmp', 'var', 'SmartBlindServer', 'MotorControl', '.dockerenv']


../MotorContorl
    ['motor.o', 'wiringPi', 'Makefile', 'libmotor.so', 'Dockerfile', 'motor.cpp']

.
    ['SmartBlindServer', 'README.md', '.dockerignore', 'tests', 'setup.py', 'Dockerfile', 'app.ini', '.python-version', 'requirements.txt', '.DS_Store']

"""
import os
# print(os.listdir("."))
lib = cdll.LoadLibrary("../MotorControl/libmotor.so")           # For docker
# lib = cdll.LoadLibrary("../../../MotorControl/libmotor.so")     # For local testing if running motor.py in it's own directory
# lib = cdll.LoadLibrary("./MotorControl/libmotor.so")              # For running locally via start.sh


class Motor:
    def __init__(self):
        self.obj = lib.Motor_new()

    def status(self) -> bool:
        return True if lib.Motor_status(self.obj) == 1 else False

    def open(self) -> None:
        lib.Motor_open(self.obj)

    def close(self) -> None:
        lib.Motor_close(self.obj)
