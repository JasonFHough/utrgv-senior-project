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

	private:

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

	int _percentStatus(){
	    return percentBlind;
	}

        void _open() {
            // Rotate motor
            rotateCounterClockwise(calculateRequiredTurningTime());

            // Toggle state
            isOpen = true;
        }

	void _percent(int percent) {

	    if(percentBlind == percent){
	    return;
            }

	    if (percentBlind > percent){
            int percentDifference = percentBlind - percent;
	    double percentSeconds = 2*calculateRequiredTurningTime()*((double)percentDifference/(double)100); 
	    //cout << "pecentBlind > percent " << percentSeconds << endl;
	    // Rotate motor
            rotateClockwise(percentSeconds);
	    }

	    else if (percentBlind < percent){
            int percentDifference = percent - percentBlind;
            double percentSeconds = 2*calculateRequiredTurningTime()*((double)percentDifference/(double)100);
	    cout << "percentBlind < percent " << percentSeconds << endl;
	    //cout << "percent is " << percent << endl;
	    cout << "percentBlind  is " << percentBlind << endl;
	    //cout << "percentDiff  is " << percentDifference << endl;

            // Rotate motor
            rotateCounterClockwise(percentSeconds);
            }
	    percentBlind = percent;

            if (percentBlind != 0 || percentBlind != 100){
            // Toggle state
            isOpen = true;
	    }

            else{
	    isOpen = false;
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

	int percentStatus(){
	    return _percentStatus();
	}

        void open() {
            return _open();
        }

        void close() {
            return _close();
        }

	void percent(int percent){
	    return _percent(percent);
	}
};


extern "C" {
    Motor* Motor_new() { return new Motor(); }
    bool Motor_status(Motor* motor) { return motor -> status(); }
     int Motor_percentStatus(Motor* motor) { return motor -> percentStatus();}
    void Motor_open(Motor* motor) { motor -> open(); }
    void Motor_close(Motor* motor) { motor -> close(); }
    void Motor_percent(Motor* motor, int percent) {motor -> percent(percent);}
}
