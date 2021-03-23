main:
	g++ -c -fPIC -lwiringPi motor.cpp -o motor.o
	g++ -shared -Wl,-soname,libmotor.so -lwiringPi -o libmotor.so motor.o

clean:
	rm -rf *.o *.so *.out

update: main

all:
	make clean
	make main
