import * as fs from "node:fs"
import {MAX_DISTANCE, MIN_DISTANCE, NUMBER_OF_CITIES} from "./constants";
import {getRandomInt} from "./utils";

export class Problem {
    private static readonly fileName = "problem.json";
    public matrix: number[][] = [];
    public optimalSolution: number = 0;

    constructor() {
        this.initializeMatrix();
        this.optimalSolution = this.findOptimalSolution();
    }

    public getCost(path: number[]): number {
        let solution = 0;
        for (let i = 0; i < NUMBER_OF_CITIES; i++) {
            solution += this.getDistance(path[i], path[i + 1]);
        }

        return solution;
    }

    public getDistance(source: number, destination: number): number {
        return this.matrix[source][destination];
    }

    private initializeMatrix(): void {
        if (fs.existsSync(Problem.fileName)) {
            const content = fs.readFileSync(Problem.fileName);
            this.matrix = JSON.parse(content.toString());
            return;
        }

        this.generateMatrix();
        fs.writeFileSync(Problem.fileName, JSON.stringify(this.matrix));
    }

    private generateMatrix(): void {
        this.matrix = new Array<number[]>(NUMBER_OF_CITIES);
        for (let i = 0; i < NUMBER_OF_CITIES; i++) {
            this.matrix[i] = new Array<number>(NUMBER_OF_CITIES);
            for (let j = 0; j < NUMBER_OF_CITIES; j++) {
                /**
                 * The cost of going between cities
                 *
                 * |  | 1 | 2 | 3
                 * |1 | ∞ | x | x
                 * |2 | x | ∞ | x
                 * |3 | x | x | ∞
                 *
                 * x = random number between MIN_DISTANCE and MAX_DISTANCE
                 */
                this.matrix[i][j] = i == j ? Number.MAX_VALUE : getRandomInt(MIN_DISTANCE, MAX_DISTANCE);
            }
        }
    }

    private findOptimalSolution(): number {
        const solutions: number[] = [];
        const nodes = Array.from({length: NUMBER_OF_CITIES}, (_, i) => i);
        for (let j = 0; j < NUMBER_OF_CITIES; j++) {
            let currentNode = j;
            const path: number[] = [];
            path.push(currentNode);
            for (let i = 0; i < NUMBER_OF_CITIES - 1; i++) {
                const node = currentNode;
                currentNode = nodes
                    .filter(x => !path.includes(x))
                    .reduce((prev, curr) => this.getDistance(node, prev) < this.getDistance(node, curr) ? prev : curr);
                path.push(currentNode);
            }
            path.push(j);
            solutions.push(this.getCost(path));
        }

        return Math.min(...solutions);
    }
}
