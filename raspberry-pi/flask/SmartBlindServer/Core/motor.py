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

    def status(self):
        return True if lib.Motor_status(self.obj) == 1 else False

    def open(self):
        lib.Motor_open(self.obj)

    def close(self):
        lib.Motor_close(self.obj)

print("Starting...")
m = Motor()
print("Status: ", m.status())
m.open()
print("Status: ", m.status())
m.close()
print("Status: ", m.status())
print("Done!")