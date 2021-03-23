#include <iostream>	
#include <wiringPi.h>

using namespace std;

#define CONTROL_PIN 1   // The WiringPi pin number to control

// For the Raspberry Pi PWM module, the PWM Frequency in Hz = 19,200,000 Hz / pwmClock / pwmRange
// i.e. If pwmClock is 192 and pwmRange is 2000 we'll get the PWM frequency = 50 

class Motor {
    private:
        void _blink() {
            int blinkCount = 5;
            for(int i = 0; i < blinkCount; i++) {
                // Toggle the LED
                digitalWrite(CONTROL_PIN, HIGH);
                delay(500);
                digitalWrite(CONTROL_PIN, LOW);
                delay(500);
            }
        }

        int _status() {
            return digitalRead(CONTROL_PIN);
        }

        void _open() {
            pwmSetMode(PWM_MODE_MS);
            pwmSetClock(192);
            pwmSetRange(2000);

            while(1) {
                // Forwards
                for(int pulse = 50; pulse <= 250; pulse++) {
                    pwmWrite(CONTROL_PIN, pulse);
                    delay(1);
                }
            }
        }

        void _close() {
            pwmSetMode(PWM_MODE_MS);
            pwmSetClock(192);
            pwmSetRange(2000);

            while(1) {
                // Backwards
                for(int pulse = 250; pulse >= 50; pulse--) {
                    pwmWrite(CONTROL_PIN, pulse);
                    delay(1);
                }
            }
        }

    public:
        Motor() {
            // Run WiringPi Setup
            if(wiringPiSetup() < 0) {
                cout << "WiringPi Setup Failed." << endl;
                return;
            }

            // Set the CONTROL_PIN mode to PWM_OUTPUT
            pinMode(CONTROL_PIN, PWM_OUTPUT);
        }

        void blink() {
            return _blink();
        }

        int status() {
            return _status();
        }

        void open() {
            return _open();
        }

        void close() {
            return _close();
        }
};

extern "C" {
    Motor* Motor_new() { return new Motor(); }
    void Motor_blink(Motor* motor) { motor -> blink(); }
    int Motor_status(Motor* motor) { return motor -> status(); }
    void Motor_open(Motor* motor) { motor -> open(); }
    void Motor_close(Motor* motor) { motor -> close(); }
}
