export const faceCards = ['J', 'Q', 'K', 'A'] as const;

export type FaceCard = typeof faceCards[number];

export const cardValue = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'] as const;

export type CardValue = typeof cardValue[number];

export const cardSuit = ['club', 'diamond', 'heart', 'spade'] as const;

export type CardSuit = typeof cardSuit[number];

export type DeckCard = `${CardValue}:${CardSuit}`;

export const createDeck = (): DeckCard[] => {
	const deck: DeckCard[] = [];
	for (const suit of cardSuit) {
		for (const value of cardValue) {
			deck.push(`${value}:${suit}` as DeckCard);
		}
	}
	return deck;
}


