import {Problem} from "./problem";
import {getAntSight, getRandomFloat, getRandomInt} from "./utils";
import {
    CONSTANT_ARGUMENTS,
    MAX_PHEROMONE,
    MIN_PHEROMONE,
    NUMBER_OF_ANTS,
    NUMBER_OF_CITIES,
    PHEROMONE_DISAPPEARANCE_COEFFICIENT
} from "./constants";

export class AntAlgorithm {
    private problem: Problem;
    public pheromoneMatrix: number[][];

    constructor(problem: Problem) {
        this.problem = problem;
        this.pheromoneMatrix = new Array<number[]>(NUMBER_OF_CITIES);
        this.initializePheromoneMatrix();
    }

    public iterate() {
        // each ant finds a path
        const paths: number[][] = []
        for (let i = 0; i < NUMBER_OF_ANTS; i++) {
            const initialCity = getRandomInt(0, NUMBER_OF_CITIES);
            const path = this.findPath(initialCity);
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
        const probabilities = new Array<number>(allowedNodes.length);
        let sum = 0.0;
        for (let i = 0; i < allowedNodes.length; i++) {
            const destinationNode = allowedNodes[i];
            const pheromone = this.pheromoneMatrix[currentNode][destinationNode];
            const antSight = getAntSight(this.problem.matrix[currentNode][destinationNode]);
            /* based on the formula: Pij = (tij)^alpha * (nij)^beta / sum((tij)^alpha * (nij)^beta)
             * where:
             * pj - probability of choosing the edge (i, j)
             * tij - pheromone
             * nij - ant sight
             * alpha, beta - constant argument
             */
            probabilities[i] = Math.pow(pheromone, CONSTANT_ARGUMENTS.alpha) *
                Math.pow(antSight, CONSTANT_ARGUMENTS.beta);
            sum += probabilities[i];
        }

        for (let i = 0; i < probabilities.length; i++) {
            probabilities[i] /= sum;
        }

        return probabilities;
    }

    private updatePheromones(paths: number[][]) {
        for (let i = 0; i < NUMBER_OF_CITIES; i++) {
            for (let j = 0; j < NUMBER_OF_CITIES; j++) {
                this.pheromoneMatrix[i][j] *= PHEROMONE_DISAPPEARANCE_COEFFICIENT;
            }
        }

        paths.forEach(path => {
            const cost = this.problem.getCost(path);
            for (let i = 0; i < NUMBER_OF_CITIES; i++) {
                /**
                 * based on the formula: Lmin/Lk
                 * where:
                 * Lmin - the length of the shortest path
                 * Lk - the length of the path for k-th ant
                 */
                this.pheromoneMatrix[path[i]][path[i + 1]] += this.problem.optimalSolution / cost;
            }
        })
    }

    private findPath(initialCity: number) {
        /**
         * The sequence of cities that the ant has visited.
         */
        const result: number[] = new Array<number>(NUMBER_OF_CITIES + 1);
        const citiesToVisit = Array.from(Array(NUMBER_OF_CITIES).keys()).filter(n => n !== initialCity);
        result[0] = initialCity;


        for (let i = 1; i < NUMBER_OF_CITIES; i++) {
            const probabilities = this.getProbabilities(result[i - 1], citiesToVisit);
            const nodeIndex = this.chooseNode(probabilities);
            result[i] = citiesToVisit[nodeIndex];
            citiesToVisit.splice(nodeIndex, 1);
        }
        const lastIndex = result.length - 1;
        result[lastIndex] = initialCity;
        return result;
    }

    /**
     * Chooses a node based on the probabilities.
     * The higher the probability, the higher the chance of being chosen.
     *
     * @returns index of the chosen node
     */
    private chooseNode(probabilities: number[]) {
        if (probabilities.length === 0) {
            throw new Error('No probabilities');
        }
        const random = Math.random();
        let sum = 0;
        for (let i = 0; i < probabilities.length; i++) {
            sum += probabilities[i];
            if (sum > random) {
                return i;
            }
        }

        return probabilities.length - 1;
    }

    private initializePheromoneMatrix() {
        this.pheromoneMatrix = new Array<number[]>(NUMBER_OF_CITIES);
        for (let i = 0; i < NUMBER_OF_CITIES; i++) {
            this.pheromoneMatrix[i] = new Array<number>(NUMBER_OF_CITIES);
            for (let j = 0; j < NUMBER_OF_CITIES; j++) {
                this.pheromoneMatrix[i][j] = i === j ? 0 : getRandomFloat(MIN_PHEROMONE, MAX_PHEROMONE);
            }
        }
    }
}
