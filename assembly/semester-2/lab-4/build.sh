#!/usr/bin/env bash

# for 32 bit use -f elf32
nasm -f elf64 main.asm -l main.lst
# for 32 bit use -m elf_i386
ld  main.o -o main.elf