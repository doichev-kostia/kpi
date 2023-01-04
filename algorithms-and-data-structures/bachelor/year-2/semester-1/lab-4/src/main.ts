import {Problem} from "./problem";
import {AntAlgorithm} from "./ant-algorithm";
import * as fs from "node:fs";

const main = () => {
    const problem = new Problem();
    const algorithm = new AntAlgorithm(problem);

    let csv = "";
    for (let i = 0; i < 50; i++) {
        for (let j = 0; j < 20; j++) {
            algorithm.iterate();
        }

        const line = 20 * (i + 1) + "," + problem.getCost(algorithm.getSolution()) + "\n";
        console.log(line);
        csv += line;
    }

    fs.writeFileSync("results.csv", csv);
}

main();
