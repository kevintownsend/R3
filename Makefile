all : src/r3.o src/packetEncoder.o

test : src/test/testSpmv
	cp src/test/runTestSpmv .
	cp src/test/testSpmv .
	cp src/test/run_simulation .
	runTestSpmv

src/test/testSpmv : src/test/testSpmv.cpp src/packetEncoder.o src/r3.o src/mmio.o
	cnyCC -I./include -o src/test/testSpmv src/test/testSpmv.cpp src/mmio.o src/packetEncoder.o src/r3.o src/cpSMVM.s

src/r3.o : src/r3.cpp 
	cnyCC -I./include -c -o src/r3.o src/r3.cpp

src/packetEncoder.o : src/packetEncoder.cpp
	cnyCC -I./include -c -o src/packetEncoder.o src/packetEncoder.cpp

src/mmio.o : src/mmio.c
	cnyCC -I./include -c -o src/mmio.o src/mmio.c

clean :
	rm -rf log src/*.o runTestSpmv testSpmv run_simulation src/test/testSpmv
	make -C sim clean
