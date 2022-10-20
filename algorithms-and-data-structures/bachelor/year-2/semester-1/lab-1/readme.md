# Lab 1

## Task
Make an algorithm to sort an array of integers stored in a file.

## Input 

A binary file with i32 integers


## Output

A sorted binary file with i32 integers

## Preparations

1. Install [nodejs](https://nodejs.org/en/) v16
2. Install [pnpm](https://pnpm.io/) v7
3. Install the dependencies with `pnpm install`

## Instructions

1. Create a binary file with the capacity of 10 MB 
```bash
npm run create-file:default
```

This will create a file called `data.bin` with 10 MB of random integers.

2. Build the src
```bash
npm run build
```
 
3. Run the program
```bash
npm run start
```

Currently, only the 10 MB files are supported. 
Because of the deadline, I didn't have time to implement the support for the files of any size.

Docker doesn't have any value yet as it was a preparation for the big files.
