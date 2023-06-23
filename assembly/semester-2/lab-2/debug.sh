#!/usr/bin/env bash

# for 32 bit use -f elf32
nasm -g -f elf64 -F dwarf main.asm -l main.lst
# for 32 bit use -m elf_i386
ld main.o -o main.elf