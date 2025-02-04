CC=cc
ASMBIN=nasm
all : asm cc link clean
asm :
	$(ASMBIN) -g -f elf decode128.asm
cc :
	$(CC) -g -m32 -std=c11 -c main.c -lm
link :
	$(CC) -g -m32 -o main main.o decode128.o -lm
clean :
	rm *.o