import path from "path";
import fs from "fs";

const file = path.join(__dirname, "../files/data.bin");
const output = path.join(__dirname, "../files/output.bin");

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

        if (isLast && integers[i] <= integers[i + 1]) {
            tmp.push(integers[i + 1]);
            chunks.push(tmp);
        }
    }
    return chunks;
}

const displayChunkOfFile = async (filePath: string, chunkSize: number) => {
    const readStream = fs.createReadStream(filePath, {highWaterMark: chunkSize});
    let iteration = 0;
    readStream.on('data', (chunk) => {
        const data = Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk);
        const integers = Array.from(new Int32Array(data.buffer));
        if (iteration === 1) {
            readStream.destroy();
            return;
        }
        console.log(integers);
        iteration++;
    })

}

const sortExternally = async (initialFilePath: string, tmpDirPath: string) => {
    console.time("Sort time");
    const data = await fs.promises.readFile(initialFilePath);
    const integers = Array.from(new Int32Array(data.buffer));
    const firstFilePath = path.join(tmpDirPath, 'first.bin');
    const secondFilePath = path.join(tmpDirPath, 'second.bin');
    const finalFilePath = path.join(tmpDirPath, 'final.bin');

    const chunks = getChunks(integers);

    const {first, second, final} = getClosestFibonacciSequence(chunks.length);
    const firstFileContent = chunks.slice(0, first).flat();
    await fs.promises.writeFile(firstFilePath, Buffer.from(Int32Array.from(firstFileContent).buffer), {
        encoding: 'binary',
        flag: 'w'
    });
    const secondFileContent = chunks.slice(first).flat();
    await fs.promises.writeFile(secondFilePath, Buffer.from(Int32Array.from(secondFileContent).buffer), {
        encoding: 'binary',
        flag: 'w'
    });

    let sortedFilePath = ''

    const polyphaseMerge = async (firstFilePath: string, secondFilePath: string, finalFilePath: string) => {
        const firstFileBuffer = await fs.promises.readFile(firstFilePath);
        const secondFileBuffer = await fs.promises.readFile(secondFilePath);


        if (firstFileBuffer.length === 0 && secondFileBuffer.length === 0) {
            return;
        }

        const firstFileIntegers = Array.from(new Int32Array(firstFileBuffer.buffer));
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

        let emptyFilePath = '';
        if (delta > 0) {
            const buffer = Buffer.from(new Int32Array(firstChunks.slice(iterableChunks.length).flat()).buffer);
            await fs.promises.writeFile(firstFilePath, buffer, {encoding: 'binary', flag: 'w'});

            // tmp
            emptyFilePath = secondFilePath;
            await fs.promises.writeFile(secondFilePath, Buffer.from(new Int32Array(0).buffer), {
                encoding: 'binary',
                flag: 'w'
            });
        } else if (delta < 0) {
            const buffer = Buffer.from(new Int32Array(secondChunks.slice(iterableChunks.length).flat()).buffer);
            await fs.promises.writeFile(secondFilePath, buffer, {encoding: 'binary', flag: 'w'});

            // tmp
            emptyFilePath = firstFilePath;
            await fs.promises.writeFile(firstFilePath, Buffer.from(new Int32Array(0).buffer), {
                encoding: 'binary',
                flag: 'w'
            });
        }


        const finalFileContent = finalChunks.flat();
        await fs.promises.writeFile(finalFilePath, Buffer.from(Int32Array.from(finalFileContent).buffer));

        if (delta === 0) {
            sortedFilePath = finalFilePath;
            return;
        }
        const [first, second] = [firstFilePath, secondFilePath, finalFilePath].filter((path) => path !== emptyFilePath);

        await polyphaseMerge(first, second, emptyFilePath);
    }

    await polyphaseMerge(firstFilePath, secondFilePath, finalFilePath);
    console.timeEnd("Sort time");

    await fs.promises.copyFile(sortedFilePath, output);
    await fs.promises.rm(tmpDirPath, {recursive: true, force: true});
}


export const main = async (filePath: string) => {
    const fileStats = await fs.promises.stat(filePath);
    const fileSize = fileStats.size;
    const tmp = await (async () => {
        try {
            await fs.promises.access(path.join(__dirname, '../files/tmp'));
            return path.join(__dirname, '../files/tmp');
        } catch (_) {
            return await fs.promises.mkdir(path.join(__dirname, "../files/tmp"), {recursive: true});
        }
    })();

    if (!tmp) {
        console.error("Failed to create tmp directory");
        process.exit(1);
    }

    console.log("60 bytes of the initial file");
    await displayChunkOfFile(filePath, 60);

    console.log("Sorting file...");
    await sortExternally(filePath, tmp);
    console.log("Done");

    console.log("60 bytes of the final file");
    await displayChunkOfFile(output, 60);
}

main(file);

