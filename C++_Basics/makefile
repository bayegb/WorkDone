CountingDriver.exe: Counting.o CountingDriver.o
	g++ Counting.o CountingDriver.o -o CountingDriver.exe -std=c++20

Counting.o: Counting.cpp
	g++ -c Counting.cpp -o Counting.o -std=c++20

CountingDriver.o: CountingDriver.cpp
	g++ -c CountingDriver.cpp -o CountingDriver.o -std=c++20

clean:
	rm *.o CountingDriver.exe
