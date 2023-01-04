import {Problem} from "./problem";
import {getRandomInt} from "./utils";
import {CONSTANT_ARGUMENTS, NUMBER_OF_ANTS, NUMBER_OF_CITIES} from "./constants";

export class AntAlgorithm {
    private problem: Problem;
    public pheromoneMatrix: number[][];

    constructor(problem: Problem) {
        this.problem = problem;
        this.pheromoneMatrix = new Array<number[]>(NUMBER_OF_CITIES);
        this.initializeMatrix();
    }

    public iterate() {
        const paths: number[][] = []
        for (let i = 0; i < NUMBER_OF_ANTS; i++) {
            const initial = getRandomInt(0, NUMBER_OF_CITIES);
            const path = this.findPath(initial);
            paths.push(path);
        }

        this.updatePheromones(paths);
    }

    public getSolution() {
        const path: number[] = []
        path.push(0);
        for (let i = 1; i < NUMBER_OF_CITIES; i++) {
            const currentIndex = path[i - 1];
            const pheromoneArray = this.pheromoneMatrix[currentIndex];
            let max = Number.MIN_VALUE;
            let maxIndex = -1;
            for (let j = 1; j < NUMBER_OF_CITIES; j++) {
                if (path.includes(j)) {
                    continue;
                }

                if (pheromoneArray[j] > max) {
                    max = pheromoneArray[j];
                    maxIndex = j;
                }
            }

            path.push(maxIndex);
        }

        path.push(0);
        return path;
    }

    private getProbabilities(currentNode: number, allowedNodes: number[]) {
        const values = new Array<number>(allowedNodes.length);
        let sum = 0.0;
        for (let i = 0; i < allowedNodes.length; i++) {
            values[i] = Math.pow(this.pheromoneMatrix[currentNode][allowedNodes[i]], CONSTANT_ARGUMENTS.alpha) *
                Math.pow(1.0 / this.problem.matrix[currentNode][allowedNodes[i]], CONSTANT_ARGUMENTS.beta);
            sum += values[i];
        }

        for (let i = 0; i < values.length; i++) {
            values[i] /= sum;
        }

        return values;
    }

    private updatePheromones(paths: number[][]) {
        for (let i = 0; i < NUMBER_OF_CITIES; i++) {
            for (let j = 0; j < NUMBER_OF_CITIES; j++) {
                this.pheromoneMatrix[i][j] *= CONSTANT_ARGUMENTS.p;
            }
        }

        paths.forEach(path => {
            const cost = this.problem.getCost(path);
            for (let i = 0; i < NUMBER_OF_CITIES; i++) {
                this.pheromoneMatrix[path[i]][path[i + 1]] += this.problem.optimalSolution / cost;
            }
        })
    }

    private findPath(initial: number) {
        const result: number[] = new Array<number>(NUMBER_OF_CITIES + 1);
        const toVisit = Array.from(Array(NUMBER_OF_CITIES).keys()).filter(n => n !== initial);
        result[0] = initial;
        for (let i = 1; i < NUMBER_OF_CITIES; i++) {
            const probabilities = this.getProbabilities(result[i - 1], toVisit);
            const nodeIndex = this.chooseNode(probabilities);
            result.push(toVisit[nodeIndex]);
            toVisit.splice(nodeIndex, 1);
        }

        result.push(initial);
        return result;
    }

    private chooseNode(probabilities: number[]) {
        const random = Math.random();
        let sum = 0.0;
        for (let i = 0; i < probabilities.length; i++) {
            sum += probabilities[i];
            if (sum > random) {
                return i;
            }
        }

        return probabilities.length - 1;
    }

    private initializeMatrix() {
        this.pheromoneMatrix = new Array<number[]>(NUMBER_OF_CITIES);
        for (let i = 0; i < NUMBER_OF_CITIES; i++) {
            this.pheromoneMatrix[i] = new Array<number>(NUMBER_OF_CITIES);
            for (let j = 0; j < NUMBER_OF_CITIES; j++) {
                /**
                 * |  |1     |2    | 3
                 * |1 |0     |0.1*d| 0.1*d
                 * |2 |0.1*d |0    | 0.1*d
                 * |3 |0.1*d |0.1*d| 0
                 *
                 * where d is the distance between cities
                 */
                this.pheromoneMatrix[i][j] = i === j ? 0 : 0.1;// to get distance between cities
            }
        }
    }
}
