#include <iostream>
#include <csignal>
#include <pigpio.h>

using namespace std;

#define CONTROL_PIN 18   // The GPIO/BCM pin number to control
#define CLOCKWISE_WIDTH 2000    // The width pulse to use for rotating clockwise
#define COUNTER_CLOCKWISE_WIDTH 1000    // The width pulse to use for rotating counter clockwise

// Servo Datasheet:
//  https://components101.com/asset/sites/default/files/component_datasheet/MG996R-Datasheet.pdf
// and
//  https://components101.com/motors/mg996r-servo-motor-datasheet

// pigpio library documentation:
//  http://abyz.me.uk/rpi/pigpio/cif.html

// gpioServo(GPIO/BCM Pin number, width value)
// width value:
//  2000 = clockwise
//  1000 = counter-clockwise

class Motor {
    private:
        bool isOpen = false;    // Start off with a closed blind

        // seconds - number of seconds to rotate before stopping
        void rotateClockwise(double seconds) {
            gpioServo(CONTROL_PIN, CLOCKWISE_WIDTH);
            time_sleep(seconds);
            stopMotor();
        }

        // seconds - number of seconds to rotate before stopping
        void rotateCounterClockwise(double seconds) {
            gpioServo(CONTROL_PIN, COUNTER_CLOCKWISE_WIDTH);
            time_sleep(seconds);
            stopMotor();
        }

        void stopMotor() {
            gpioServo(CONTROL_PIN, 0);
        }

        bool _status() {
            return isOpen;
        }

        void _open() {
            // Rotate motor
            rotateCounterClockwise(1);

            // Toggle state
            isOpen = !isOpen;
        }

        void _close() {
            // Rotate motor
            rotateClockwise(1);

            // Toggle state
            isOpen = !isOpen;
        }

    public:
        Motor() {
            // Run pigpio Setup
            if (gpioInitialise() < 0) {
                return;
            }
        }

        ~Motor() {
            gpioTerminate();
        }

        bool status() {
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
    bool Motor_status(Motor* motor) { return motor -> status(); }
    void Motor_open(Motor* motor) { motor -> open(); }
    void Motor_close(Motor* motor) { motor -> close(); }
}
