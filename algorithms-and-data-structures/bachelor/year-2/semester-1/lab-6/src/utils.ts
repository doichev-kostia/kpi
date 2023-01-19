import produce from "immer";

export const shuffle = <T extends any[]>(array: T): T => {
	return produce(array, draft => {
		for (let i = draft.length - 1; i > 0; i--) {
			const j = Math.floor(Math.random() * (i + 1));
			[draft[i], draft[j]] = [draft[j], draft[i]];
		}
	});
};

export const getRandomInt = (min: number, max: number) => {
	return Math.floor(Math.random() * (max - min + 1)) + min;
}
