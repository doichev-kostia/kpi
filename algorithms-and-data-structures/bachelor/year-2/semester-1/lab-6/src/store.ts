import {create} from "zustand";
import {z} from "zod";
import {CardValue, createDeck, DeckCard, FaceCard} from "./deck";
import produce from "immer";

export const faceCardScore: Readonly<Record<FaceCard, number>> = {
	'A': 11,
	'K': 4,
	'Q': 3,
	'J': 2,
} as const;

type SetBankCallback = (bank: number) => number;
type SetBank = (callback: SetBankCallback) => void;

const actor = ['player', 'computer'] as const;

export type Actor = typeof actor[number];

type GameState = {
	bank: number;
	playerHand: DeckCard[];
	computerHand: DeckCard[];
	deck: DeckCard[];

	actions: {
		setBank: SetBank;
		getScore: (hand: Actor) => number;
		resetGame: () => void;
		addCardToHand: (actr: Actor, value: DeckCard) => void;
		removeFromDeck: (value: DeckCard) => void;
		getLastDeckCard: () => DeckCard;
		getFirstDeckCard: () => DeckCard;
	}
}


const getDefaultValues = () => {
	const deck = createDeck();
	return {
		bank: 0,
		playerHand: [],
		computerHand: [],
		deck,
	} as {
		[K in Exclude<keyof GameState, 'actions'>]: GameState[K] ;
	};
}

export const calculateScore = (hand: DeckCard[]) => {
	return hand.reduce((acc, card) => {
		const value = card.split(':')[0] as CardValue;
		if (value in faceCardScore) {
			return acc + faceCardScore[value as FaceCard];
		}
		return acc + Number(value);
	}, 0);
}

export const useGameStore = create<GameState>((set, get,) => ({
	...getDefaultValues(),

	actions: {
		setBank: (callback: SetBankCallback) => set((state) => ({bank: callback(state.bank)})),
		getScore: (hand: Actor) => {
			const _hand = z.enum(actor).parse(hand);
			return calculateScore(get()[`${_hand}Hand`]) ?? 0;
		},
		resetGame: () => set({
			...getDefaultValues(),
		}),
		addCardToHand: (actr: Actor, value: DeckCard) => {
			set((state) => {
				const _actr = z.enum(actor).parse(actr);
				const newHand = produce(state[`${_actr}Hand`], (draft) => {
					draft.push(value);
				})
				return ({
					[`${_actr}Hand`]: newHand,
				});
			});
		},
		removeFromDeck: (value: DeckCard) => {
			set((state) => {
				const newDeck = produce(state.deck, (draft) => {
					const index = draft.indexOf(value);
					if (index > -1) {
						draft.splice(index, 1);
					}
				});
				return ({
					deck: newDeck,
				});
			});
		},
		getLastDeckCard: () => {
			const deck = get().deck;
			return deck[deck.length - 1];
		},
		getFirstDeckCard: () => {
			const deck = get().deck;
			return deck[0];
		}
	}
}))
