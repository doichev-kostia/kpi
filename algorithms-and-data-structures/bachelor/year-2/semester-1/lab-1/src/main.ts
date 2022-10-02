import os from 'os';
import path from "path";
import fs from "fs";

const availableRAM = os.freemem();
const file = path.join(__dirname, "../files/data.bin");
const output = path.join(__dirname, "../files/output.bin");

export const main = async (filePath: string) => {
    const fileStats = await fs.promises.stat(filePath);
    const fileSize = fileStats.size;
    const isBiggerThanAvailableRAM = fileSize > availableRAM;

    const buffer = await fs.promises.readFile(filePath);
    const array = new Int32Array(buffer.buffer);
    const sortedArray = array.sort((a, b) => a - b);

    await fs.promises.writeFile(output, Buffer.from(sortedArray.buffer), {flag: "w", encoding: "binary"});
}

main(file);

