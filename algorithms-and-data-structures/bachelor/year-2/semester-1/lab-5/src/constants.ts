export const NUMBER_OF_CITIES = 300;
export const NUMBER_OF_ANTS = 45;
export const MIN_DISTANCE = 5;
export const MAX_DISTANCE = 150;
export const INITIAL_PHEROMONE = 0.1;
export const CONSTANT_ARGUMENTS = {
  alpha: 3,
  beta: 2,
  p: 0.3,
};

export const RESULTS_CHECKPOINT = 20;

export const NUMBER_OF_ITERATIONS = 1000;

/**
 * according to the formula:
 * pheromone[i][j] = (1 - p) * pheromone[i][j] + deltaPheromone[i][j]
 */
export const PHEROMONE_DISAPPEARANCE_COEFFICIENT = 1 - CONSTANT_ARGUMENTS.p;
