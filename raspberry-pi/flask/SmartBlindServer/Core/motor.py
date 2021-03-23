from ctypes import cdll


"""
../
    ['sys', 'home', 'mnt', 'opt', 'boot', 'lib64', 'proc', 'etc', 'srv', 'bin', 'media', 'usr', 'dev', 'lib', 'sbin', 'run', 'root', 'tmp', 'var', 'SmartBlindServer', 'MotorControl', '.dockerenv']

../MotorControl
    ['libmotor.so']

.
    ['SmartBlindServer', 'README.md', '.dockerignore', 'tests', 'setup.py', 'Dockerfile', 'app.ini', '.python-version', 'requirements.txt', '.DS_Store']

"""
import os
# print(os.listdir("../MotorControl"))
# print(os.listdir("../SmartBlindServer"))
# lib = cdll.LoadLibrary("../MotorControl/libmotor.so")
lib = cdll.LoadLibrary("../../../MotorControl/libmotor.so")


class Motor:
    def __init__(self):
        self.obj = lib.Motor_new()

    def blink(self):
        lib.Motor_blink(self.obj)

    def status(self):
        return lib.Motor_status(self.obj)

    def open(self):
        lib.Motor_open(self.obj)

    def close(self):
        lib.Motor_close(self.obj)

print("Starting...")
m = Motor()
m.open()
print("Done!")