export const getRandomInt = (min: number, max: number) => {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}


export const getAntSight = (distance: number) => {
    return 1 / distance;
}
