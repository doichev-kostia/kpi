import {Problem} from "./problem";
import {AntAlgorithm} from "./ant-algorithm";
import * as fs from "node:fs";
import {NUMBER_OF_ITERATIONS, RESULTS_CHECKPOINT} from "./constants";

const main = () => {
    const problem = new Problem();
    const algorithm = new AntAlgorithm(problem);

    let csv = "";
    const iterations = NUMBER_OF_ITERATIONS / RESULTS_CHECKPOINT;
    for (let i = 0; i < iterations; i++) {
        for (let j = 0; j < RESULTS_CHECKPOINT; j++) {
            algorithm.iterate();
        }

        const line = RESULTS_CHECKPOINT * (i + 1) + "," + problem.getCost(algorithm.getSolution()) + "\n";
        console.log(line);
        csv += line;
    }

    fs.writeFileSync("results.csv", csv);
}

main();
