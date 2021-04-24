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

	    int percentBlind = 0;  //Start off closed  percent 0%

        double calculateRequiredTurningTime() {
            double rotationsPerSecond = 1.36;   // The "eyeballed" amount of seconds it takes for the motor to rotate once
            int numberOfRotations = 5;          // The number of physical rotations is takes to change the blind state (closed -> open)
            return rotationsPerSecond * numberOfRotations;
        }

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
            rotateCounterClockwise(calculateRequiredTurningTime());

            // Toggle state
            isOpen = true;
        }

	void _percent(int percent) {
            
	    if(percentBlind == percent){
	    percentBlind = percent;
            };

	    if (percentBlind > percent){
            int percentDifference = percentBlind - percent;
	    double percentSeconds = 25.5(percentDifference/100); 

	    // Rotate motor
            rotateClockwise(percentSeconds);
	    };

            // Update the open/closed blind state
            // The blind is closed if the percentage is 0% or 100%, otherwise it is open
            if (currentPercentage == 0 || currentPercentage == 100) {
                isOpen = false;
            } else {
                isOpen = true;
            }
        }


        void _close() {
            // Rotate motor
            rotateClockwise(calculateRequiredTurningTime());

            // Toggle state
            isOpen = false;
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

	void percent(int percent){
	    return _percent(percent)
	};
};


extern "C" {
    Motor* Motor_new() { return new Motor(); }
    bool Motor_status(Motor* motor) { return motor -> status(); }
    void Motor_open(Motor* motor) { motor -> open(); }
    void Motor_close(Motor* motor) { motor -> close(); }
    void Motor_percent(Motor* motor, int percent) {motor -> percent(percent);}
}
