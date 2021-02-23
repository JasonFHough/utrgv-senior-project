from ctypes import cdll, c_int
lib = cdll.LoadLibrary('../../MotorControl/libmotor.so')


class Motor:
    def __init__(self):
        self.obj = lib.Motor_new()

    def blink(self):
        lib.Motor_blink(self.obj)

    def status(self):
        lib.Motor_status.restype = c_int
        lib.Motor_status(self.obj)

    def open(self):
        lib.Motor_open(self.obj)

    def close(self):
        lib.Motor_close(self.obj)

m = Motor()
print(m.status())
m.blink()
