# Project Description

## Minimum Viable Product (MVP)

Create a system in which a mobile app remotely controls a Raspberry Pi connected to a motor that rotates a window blind to the open/close state

## MVP Requirements

- [ ] Mobile App
  - [ ] Display the current state of the window blind
  - [ ] Create a single button that toggles the current state of the window blind by sending HTTP requests
- [ ] Raspberry Pi
  - [x] Create a publicly accessible REST API server that interacts with the Raspberry Pi's GPIO
  - [x] Create a circuit to connect a motor to the Raspberry Pi
  - [ ] Physically attach the motor to the window blind's turning rod to rotate the blinds
  - [ ] Create REST API endpoints that operate the motor such that the window blind opens and closes

## Future Expansion

- [ ] Mobile App
  - [ ] Implement a seemless visual transition between the window blind open state to closed state, and vice versa.
  - [ ] Display exact percentage of the window blind angle  
  100% = completely open, 0% = completely closed
  - [ ] Display other sensor data such as temperature, daytime/nightime, etc.
- [ ] Raspberry Pi
  - [ ] Provide an endpoint that returns the exact current position of the motor in percentage form  
  100% = completely open, 0% = completely closed
  - [ ] Containerize and/or automate the application for easy deployment
  - [ ] Connect other sensor hardware to the circuit and expose their sensor readings to a REST API endpoint

## Visual Overview

![Low Fidelity Project Overview Image](./CSCI%204390%20-%20Low%20Fidelity%20Project%20Overview%20Mock-up.jpg)