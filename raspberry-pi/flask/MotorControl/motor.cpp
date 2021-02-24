#include <iostream>	
#include <wiringPi.h>

using namespace std;

#define CONTROL_PIN 3   // The WiringPi pin number to control

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
            digitalWrite(CONTROL_PIN, HIGH);
        }

        void _close() {
            digitalWrite(CONTROL_PIN, LOW);
        }

    public:
        Motor() {
            // Run WiringPi Setup
            if(wiringPiSetup() < 0) {
                cout << "WiringPi Setup Failed." << endl;
                return;
            }

            // Set the CONTROL_PIN mode to OUT
            pinMode(CONTROL_PIN, OUTPUT);
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
