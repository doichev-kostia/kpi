import fs from "fs";
import yargs from "yargs";
import {hideBin} from "yargs/helpers";

const MIN_FILE_SIZE_IN_BYTES = 10 * 1024 * 1024;
const MAX_BUFFER_SIZE_IN_BYTES = 20 * 1024 * 1024;
const INT_SIZE_IN_BYTES = 4;
const MAX_INT = Math.pow(2, 32) / 2 - 1;
const MIN_INT = -Math.pow(2, 32) / 2;

const argv = yargs(hideBin(process.argv))
    .usage("Usage: $0 --file [string] --size [number] --min [number] --max [number]")
    .options({
        file: {type: "string", demandOption: true, alias: "f", description: "File name"},
        size: {
            type: "number",
            alias: "s",
            default: MIN_FILE_SIZE_IN_BYTES,
            description: "File size in bytes",
            defaultDescription: "10MB"
        },
        min: {type: "number", default: 0, description: "Min integer"},
        max: {type: "number", default: 1000, description: "Max integer"},
    })
    .check(({size, min, max}) => {
        // if (size < MIN_FILE_SIZE_IN_BYTES) {
        //     throw new Error(`File size should be at least ${MIN_FILE_SIZE_IN_BYTES} bytes`);
        // }
        if (min > max) {
            throw new Error("Min should be less than max");
        }

        if (!Number.isInteger(min) || !Number.isInteger(max)) {
            throw new Error("Min and max should be integers");
        }

        if (max > MAX_INT) {
            throw new Error(`Max should be less or equal to the positive signed 32-bit integer. Max value is ${MAX_INT}`);
        }

        if (min < MIN_INT) {
            throw new Error(`Min should be greater of equal to the negative signed 32-bit integer. Min value is ${MIN_INT}`);
        }

        return true;
    })
    .help('h')
    .alias('h', 'help')
    .parseSync();

const randomInteger = (min: number, max: number) => {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

const createFile = () => {
    const {file, max, min, size} = argv;
    const writeStream = fs.createWriteStream(file, {flags: "w", encoding: "binary"});
    if (size < MAX_BUFFER_SIZE_IN_BYTES) {
        const integers = new Array(Math.floor(size / INT_SIZE_IN_BYTES)).fill(0).map(() => randomInteger(min, max));
        const buffer = Buffer.from(Int32Array.from(integers).buffer);
        writeStream.write(buffer, "binary");
        writeStream.end();
        return;
    }

    let remainingBytes = size;
    const parts = Math.floor(size / MAX_BUFFER_SIZE_IN_BYTES);
    for (let i = 0; i < parts; i++) {
        const size = remainingBytes > MAX_BUFFER_SIZE_IN_BYTES ? MAX_BUFFER_SIZE_IN_BYTES : remainingBytes;
        const integers = new Array(Math.floor(size / INT_SIZE_IN_BYTES)).fill(0).map(() => randomInteger(min, max));
        const buffer = Buffer.from(Int32Array.from(integers).buffer);
        writeStream.write(buffer, "binary");
        remainingBytes -= size;
    }

    writeStream.end();
}

createFile();
