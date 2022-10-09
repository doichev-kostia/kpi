import path from "path";
import fs from "fs";
import * as process from "process";

// const MAX_BUFFER_SIZE_IN_BYTES = 20 * 1024 * 1024;
const file = path.join(__dirname, "../files/data.bin");
// const output = path.join(__dirname, "../files/output.bin");

const sortExternally = (initialFilePath: string, tmpDirPath: string) => {
    const readStream = fs.createReadStream(initialFilePath);
    const firstHalfWriteStream = fs.createWriteStream(path.join(tmpDirPath, 'a.bin'), {flags: "w", encoding: "binary"});
    const secondHalfWriteStream = fs.createWriteStream(path.join(tmpDirPath, 'b.bin'), {
        flags: "w",
        encoding: "binary"
    });


    readStream.on("data", (chunk) => {
        const data = Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk, "binary");
        const array = new Int32Array(data.buffer);
        const a = array.filter((value) => value % 2 === 0);
        const b = array.filter((value) => value % 2 !== 0);
        firstHalfWriteStream.write(Buffer.from(a.buffer));
        secondHalfWriteStream.write(Buffer.from(b.buffer));
    })

    readStream.on("end", () => {
        secondHalfWriteStream.end();
        firstHalfWriteStream.end();
    });

    const firstHalfReadStream = fs.createReadStream(path.join(tmpDirPath, 'a.bin'));
    const secondHalfReadStream = fs.createReadStream(path.join(tmpDirPath, 'b.bin'));

    const outputWriteStream = fs.createWriteStream(initialFilePath, {flags: "w", encoding: "binary"});
    let firstHalfBuffer: Buffer | null = null;
    let secondHalfBuffer: Buffer | null = null;

    firstHalfReadStream.on("data", (chunk) => {
        firstHalfBuffer = Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk, "binary");
    })

    secondHalfReadStream.on("data", (chunk) => {
        secondHalfBuffer = Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk, "binary");
    });

    firstHalfReadStream.on("data", (chunk) => {
        const data = Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk, "binary");
        const arr = new Int32Array(data.buffer);

        secondHalfReadStream.on("data", (chunk) => {
            const data = Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk, "binary");
            const barr = new Int32Array(data.buffer);
            const final = new Int32Array(arr.length + barr.length);
            let ptr = 0;

            for (let i = 0; i < arr.length; i++) {
                if (arr[i] < barr[i]) {
                    final[ptr] = arr[i];
                    ++ptr;
                    final[ptr] = barr[i];
                } else {
                    final[ptr] = barr[i];
                    ++ptr;
                    final[ptr] = arr[i];
                }
            }

            console.log({
                arr,
                barr,
                final
            })
            outputWriteStream.write(Buffer.from(final.buffer));
        })
    })
}

export const main = async (filePath: string) => {
    const fileStats = await fs.promises.stat(filePath);
    const fileSize = fileStats.size;
    const tmp = await fs.promises.mkdir(path.join(__dirname, "../files/tmp"), {recursive: true});

    if (!tmp) {
        console.error("Failed to create tmp directory");
        process.exit(1);
    }

    sortExternally(filePath, tmp);
}

main(file);

