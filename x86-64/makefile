CC=cc
ASMBIN=nasm
CFLAGS=-g -m64 -std=c11
ASMFLAGS=-g -f elf64
LDFLAGS=-g -m64 -lm
TARGET=main

all: asm cc link clean

asm:
	$(ASMBIN) $(ASMFLAGS) -o decode128_64.o decode128_64.asm

cc:
	$(CC) $(CFLAGS) -c main.c -o main.o

link:
	$(CC) $(LDFLAGS) -o $(TARGET) main.o decode128_64.o

clean:
	rm -f *.o 