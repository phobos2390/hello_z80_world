emulator: 
	mkdir -p build
	cd build; cmake3 ..
	cd build; make

run: emulator assemble
	build/z80_emulator build/main.z80bin

valgrind: emulator assemble
	valgrind build/z80_emulator build/main.z80bin

assemble: emulator
	spasm src/assembler/main.asm build/main.z80bin


#build:
#	mkdir -p build
#	cd build; cmake ..


clean: 
	rm -rf build
