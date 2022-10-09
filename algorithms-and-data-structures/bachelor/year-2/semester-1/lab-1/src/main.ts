import path from "path";
import fs from "fs";

// const MAX_BUFFER_SIZE_IN_BYTES = 20 * 1024 * 1024;
const file = path.join(__dirname, "../files/data.bin");
// const output = path.join(__dirname, "../files/output.bin");

// init:  [33, 48, 24, 20, 20, 8, 33, 22, 46, 16, 29, 8, 24, 17, 5, 39, 31, 47, 44, 4]
// final: [4, 5, 8, 8, 16, 17, 20, 20, 22, 24, 24, 29, 31, 33, 33, 39, 44, 46, 47, 48]

const getClosestFibonacciSequence = (number: number) => {
    let first = 0;
    let second = 1;
    let final = 1;
    while (final < number) {
        first = second;
        second = final;
        final = first + second;
    }

    return {
        first,
        second,
        final
    };
}

const getChunks = (integers: number[]) => {
    const chunks: number[][] = [];
    let tmp: number[] = [];
    for (let i = 0; i < integers.length - 1; i++) {
        const isLast = i === integers.length - 2;
        tmp.push(integers[i]);
        if (integers[i] > integers[i + 1]) {
            chunks.push(tmp);
            tmp = [];
            if (isLast) {
                chunks.push([integers[i + 1]]);
            }
        }

        if (isLast && integers[i] < integers[i + 1]) {
            tmp.push(integers[i + 1]);
            chunks.push(tmp);
        }
    }
    return chunks;
}

const sortExternally = async (initialFilePath: string, tmpDirPath: string) => {
    const data = await fs.promises.readFile(initialFilePath);
    const integers = Array.from(new Int32Array(data.buffer));
    const firstFilePath = path.join(tmpDirPath, 'first.bin');
    const secondFilePath = path.join(tmpDirPath, 'second.bin');
    const finalFilePath = path.join(tmpDirPath, 'final.bin');
    const chunks = getChunks(integers);

    console.log(`Number of chunks: ${chunks.length}`);

    const {first, second, final} = getClosestFibonacciSequence(chunks.length);
    const firstFileContent = chunks.slice(0, first).flat();
    await fs.promises.writeFile( firstFilePath, Buffer.from(Int32Array.from(firstFileContent).buffer), {
        encoding: 'binary',
        flag: 'w'
    });
    const secondFileContent = chunks.slice(first).flat();
    await fs.promises.writeFile(secondFilePath, Buffer.from(Int32Array.from(secondFileContent).buffer), {
        encoding: 'binary',
        flag: 'w'
    });

    const firstFileBuffer = await fs.promises.readFile(firstFilePath);
    const firstFileIntegers = Array.from(new Int32Array(firstFileBuffer.buffer));
    const secondFileBuffer = await fs.promises.readFile(secondFilePath);
    const secondFileIntegers = Array.from(new Int32Array(secondFileBuffer.buffer));


    const firstChunks: number[][] = getChunks(firstFileIntegers);
    const secondChunks: number[][] = getChunks(secondFileIntegers);

    const delta = firstChunks.length - secondChunks.length;

    const finalChunks: number[][] = [];
    let iterableChunks: number[][] = firstChunks;
    if (delta > 0) {
        iterableChunks = secondChunks;
    }

    for (let i = 0; i < iterableChunks.length; i++) {
        const firstChunk = firstChunks[i];
        const secondChunk = secondChunks[i];
        finalChunks.push([...firstChunk, ...secondChunk].sort((a, b) => a - b));
    }

    if (delta > 0) {
        const buffer = Buffer.from(new Int32Array(firstChunks.slice(iterableChunks.length).flat()).buffer);
        await fs.promises.writeFile(firstFilePath, buffer, { encoding: 'binary', flag: 'w' });
        // tmp
        await fs.promises.writeFile(secondFilePath, Buffer.from(new Int32Array(0).buffer), { encoding: 'binary', flag: 'w' });
    } else if (delta < 0) {
       const buffer = Buffer.from(new Int32Array(secondChunks.slice(iterableChunks.length).flat()).buffer);
       await fs.promises.writeFile(secondFilePath, buffer, { encoding: 'binary', flag: 'w' });

        // tmp
        await fs.promises.writeFile(firstFilePath, Buffer.from(new Int32Array(0).buffer), { encoding: 'binary', flag: 'w' });
    }

    const finalFileContent = finalChunks.flat();
    console.log({integers, finalFileContent});
    await fs.promises.writeFile(finalFilePath, Buffer.from(Int32Array.from(finalFileContent).buffer));
}

export const main = async (filePath: string) => {
    const fileStats = await fs.promises.stat(filePath);
    const fileSize = fileStats.size;
    const tmp = await (async () => {
        try {
            await fs.promises.access(path.join(__dirname, '../files/tmp'));
            return path.join(__dirname, '../files/tmp');
        } catch (_) {
            await fs.promises.mkdir(path.join(__dirname, "../files/tmp"), {recursive: true});
        }
    })();

    if (!tmp) {
        console.error("Failed to create tmp directory");
        process.exit(1);
    }

    await sortExternally(filePath, tmp);
}

main(file);

