import {create} from "zustand";
import {z} from "zod";
import {CardValue, createDeck, DeckCard, FaceCard} from "./deck";
import produce from "immer";
import {getRandomInt, shuffle} from "./utils";

export const faceCardScore: Readonly<Record<FaceCard, number>> = {
	'A': 11,
	'K': 10,
	'Q': 10,
	'J': 10,
} as const;

type SetBankCallback = (bank: number) => number;
type SetBank = (callback: SetBankCallback) => void;

const actor = ['player', 'computer', 'dealer'] as const;

export type Actor = typeof actor[number];

const sequence = ['computer', 'player', 'dealer'] as const;

type GameState = {
	bank: number;
	playerHand: DeckCard[];
	computerHand: DeckCard[];
	dealerHand: DeckCard[];
	deck: DeckCard[];
	sequence: typeof sequence;
	activeActorIndex: number;

	actions: {
		setBank: SetBank;
		getScore: (hand: Actor) => number;
		resetGame: () => void;
		launchNewRound: () => void;
		resetHand: (actr: Actor) => void;
		addCardToHand: (actr: Actor, value: DeckCard) => void;
		removeFromDeck: (value: DeckCard) => void;
		getLastDeckCard: () => DeckCard;
		getFirstDeckCard: () => DeckCard;
		nextActor: () => void;
		removeActor: (index: number) => void;
	}
}


const getDefaultValues = () => {
	const deck = shuffle(createDeck());
	return {
		bank: getRandomInt(3, 10),
		playerHand: [],
		computerHand: [],
		dealerHand: [],
		deck,
		sequence: structuredClone(sequence),
		activeActorIndex: 0,
	} as {
		[K in Exclude<keyof GameState, 'actions'>]: GameState[K];
	};
}

export const calculateScore = (hand: DeckCard[]) => {
	return hand.reduce((acc, card) => {
		const value = card.split(':')[0] as CardValue;
		if (value === 'A') {
			// ace can have 2 values. either 1 or 11
			return acc + faceCardScore[value] > 21 ? acc + 1 : acc + faceCardScore[value];
		} else if (value in faceCardScore) {
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
		launchNewRound: () => {
			const {actions, deck} = get();
			const MIN_NUMBER_OF_CARDS = 8;

			if (MIN_NUMBER_OF_CARDS > deck.length) {
				actions.resetGame();
				return;
			}

			actions.resetHand('dealer');
			actions.resetHand('player');
			actions.resetHand('computer');

			actions.addCardToHand('dealer', actions.getLastDeckCard());
			actions.addCardToHand('player', actions.getLastDeckCard());
			actions.addCardToHand('computer', actions.getLastDeckCard());

			actions.addCardToHand('dealer', actions.getLastDeckCard());
			actions.addCardToHand('player', actions.getLastDeckCard());
			actions.addCardToHand('computer', actions.getLastDeckCard());

			set((state) => ({
				sequence: structuredClone(sequence),
				activeActorIndex: 0,
			}))
		},
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
		resetHand: (actr: Actor) => {
			const _actr = z.enum(actor).parse(actr);
			set((state) => ({
				[`${_actr}Hand`]: [],
			}));
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
			const card = deck[deck.length - 1];
			if (!card) {
				throw new Error('Deck is empty');
			}
			get().actions.removeFromDeck(card);
			return card;
		},
		getFirstDeckCard: () => {
			const deck = get().deck;
			const card = deck[0];
			if (!card) {
				throw new Error('Deck is empty');
			}
			get().actions.removeFromDeck(card);
			return card;
		},
		nextActor: () => {
			set(state => {
				const {sequence, activeActorIndex} = state;
				const nextIndex = activeActorIndex + 1;
				if (nextIndex >= sequence.length) {
					return ({
						activeActorIndex: 0,
					});
				}
				return ({
					activeActorIndex: nextIndex,
				});
			})
		},
		removeActor: (index: number) => {
			set(state => {
				const {sequence, activeActorIndex} = state;

				const newSequence = produce(sequence, (draft) => {
					draft.splice(index, 1);
				});

				if (activeActorIndex > newSequence.length - 1) {
					return ({
						activeActorIndex: 0,
						sequence: newSequence,
					});
				}

				return ({
					sequence: newSequence,
				});
			})
		},
	}
}))
