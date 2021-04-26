# A class to mimic the structure of what cdll.LoadLibrary(libmotor.so) would contain
class FakeCLib():
    def Motor_new(self):
        pass

    def Motor_status(self, obj):
        pass

    def Motor_currentPercent(self, obj):
        pass
    
    def Motor_moveToPercent(self, obj, percent):
        pass

    def Motor_open(self, obj):
        pass

    def Motor_close(self, obj):
        pass
