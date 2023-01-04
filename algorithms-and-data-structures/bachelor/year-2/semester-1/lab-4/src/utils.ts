export const getRandomInt = (min: number, max: number) => {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

export const getRandomFloat = (min: number, max: number, length: number = 1) => {
    const random =  Math.random() * (max - min) + min;
    return Math.round(random * Math.pow(10, length)) / Math.pow(10, length);
}

export const getAntSight = (distance: number) => {
    return 1 / distance;
}
