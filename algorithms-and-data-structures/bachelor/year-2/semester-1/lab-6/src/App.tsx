import {Card} from "./card";
import {useGameStore} from "./store";
import {CardSuit, CardValue} from "./deck";
import React, {useEffect, useState} from "react";
import {Button, Dialog, DialogContent, DialogTitle, Typography} from "@mui/material";
import {shallow} from "zustand/shallow";
import cx from "classnames";
import {toast} from "react-toastify";

const MIN_DEALER_SCORE = 17;

const deckCardStyles = "absolute rotate-90 left-5 -top-3"

const numberFormatter = Intl.NumberFormat('en-US', {style: "currency", currency: 'USD', maximumFractionDigits: 0});

function App() {
	const [isGameStarted, setIsGameStarted] = useState(false);
	const [isDialogOpen, setIsDialogOpen] = useState(false);
	const {
		bank,
		playerHand,
		computerHand,
		sequence,
		activeActorIndex,
		deck,
		actions,
		dealerHand
	} = useGameStore(
		(state) => ({
			...state,
		}), shallow)


	const activeActor = sequence[activeActorIndex];
	const playerScore = actions.getScore('player');
	const computerScore = actions.getScore('computer');
	const dealerScore = actions.getScore('dealer');

	useEffect(() => {
		if (playerScore === 21) {
			toast.success('Blackjack! You win!');
			actions.removeActor(sequence.indexOf('player'));
		}

		if (computerScore === 21) {
			toast.success('Blackjack! Computer wins!');
			actions.removeActor(sequence.indexOf('computer'));
		}

		if (activeActor === 'dealer') {
			if (dealerScore < MIN_DEALER_SCORE) {
				actions.addCardToHand('dealer', actions.getLastDeckCard());
			}
			const updatedDealerScore = actions.getScore('dealer');

			if (computerScore > updatedDealerScore) {
				toast.success('Computer wins!');
			}

			if (computerScore <= updatedDealerScore) {
				toast.success('Dealer wins computer!');
			}

			if (playerScore > updatedDealerScore) {
				toast.success('You win!');
			}

			if (playerScore <= updatedDealerScore) {
				toast.error('You lose!');
			}

			setTimeout(() => {
				actions.launchNewRound();
			}, 4000)
		} else if (activeActor === 'computer' && computerScore) {
			const shouldHit = Math.random() > 0.5;
			setTimeout(() => {
				if (computerScore < 17 && shouldHit) {
					actions.addCardToHand('computer', actions.getLastDeckCard());
					toast.info('Computer hits!');
				} else {
					toast.info('Computer stands!');
				}

				const updatedComputerScore = actions.getScore('computer');

				if (updatedComputerScore > 21) {
					toast.success('Computer busts!');
					actions.removeActor(sequence.indexOf('computer'));
				}

				actions.nextActor();
			}, 3000)
		}
	}, [activeActorIndex, computerScore])

	const handlePlayerHit = () => {
		actions.addCardToHand('player', actions.getLastDeckCard());
		const score = actions.getScore('player');
		if (score > 21) {
			actions.removeActor(sequence.indexOf('player'));
			setIsDialogOpen(true);
		}
		actions.nextActor();
	}

	const isPlayerTurn = sequence[activeActorIndex] === 'player';
	const isDealerTurn = sequence[activeActorIndex] === 'dealer';

	return (
		<div className="grid grid-rows-[auto_1fr] bg-green-300 min-h-screen px-5">
			<header className="flex justify-between gap-4 py-4">
				<div>
					<h1>21 point game</h1>
				</div>
				<div>
					<p>Balance: {numberFormatter.format(bank)}</p>
				</div>
			</header>
			<main>
				<section className="mb-6 text-center">
					{!isGameStarted ? (
						<div className="flex justify-center mb-6" onClick={() => {
							setIsGameStarted(true);
						}}>
							<Button variant="contained" onClick={() => actions.launchNewRound()}>Start the game</Button>
						</div>
					) : (
						<Typography>
							Current turn:
							<span className="text-amber-600">{sequence[activeActorIndex]}</span>
						</Typography>
					)}
				</section>
				<section className="flex justify-center">
					<div className="max-w-md text-center">
						<Typography className="mb-6">Dealer</Typography>
						<ul className="grid auto-cols-auto grid-flow-col gap-4 min-h-[7rem]">
							{dealerHand.map((card, i) => {
								const [value, suit] = card.split(':') as [CardValue, CardSuit];

								const isCardHidden = i === 1 && !isDealerTurn;
								return (
									<li key={card}>
										<Card value={value} suit={suit} faceUp={!isCardHidden}/>
									</li>
								);
							})}
						</ul>
						<p className='text-sm'>
							Score is: {isDealerTurn ? dealerScore : '?'}
						</p>
					</div>
				</section>
				<section className="flex justify-between">
					<div className="max-w-sm">
						<Typography className="mb-6">Computer</Typography>
						<div className="min-h-[7rem]">
							<ul className="grid auto-cols-auto grid-flow-col gap-4">
								{computerHand.map((card) => {
									const [value, suit] = card.split(':') as [CardValue, CardSuit];

									return (
										<li key={card}>
											<Card value={value} suit={suit} faceUp/>
										</li>
									);
								})}
							</ul>
							<p className='text-sm'>
								Score is: {computerScore}
							</p>
						</div>
					</div>
					<div>
						<Typography className="mb-6">Deck</Typography>
						<div
							className="min-w-[10rem]">
							<ul className="relative pb-5 min-h-[7rem]">
								<li className={cx(deckCardStyles, 'z-[4]')}>
									<Card value='2' suit='heart' faceUp={false}/>
								</li>
								<li className={cx(deckCardStyles, 'z-[3] translate-y-1')}>
									<Card value='2' suit='heart' faceUp={false}/>
								</li>
								<li className={cx(deckCardStyles, 'z-[2] translate-y-2')}>
									<Card value='2' suit='heart' faceUp={false}/>
								</li>
								<li className={cx(deckCardStyles, 'z-[1] translate-y-3')}>
									<Card value='2' suit='heart' faceUp={false}/>
								</li>
							</ul>
							<Typography>Available cards: {deck.length} </Typography>
						</div>

					</div>
				</section>
				<section className="flex justify-center">
					<div className="max-w-md text-center">
						<Typography className="mb-6">Player</Typography>
						<ul className="grid auto-cols-auto grid-flow-col gap-4 min-h-[7rem]">
							{playerHand.map((card) => {
								const [value, suit] = card.split(':') as [CardValue, CardSuit];

								return (
									<li key={card}>
										<Card value={value} suit={suit} faceUp/>
									</li>
								);
							})}
						</ul>
						<p className='text-sm'>
							Score is: {playerScore}
						</p>
						<div className="flex justify-between gap-5">
							<Button variant="contained" disabled={!isPlayerTurn}
									onClick={() => handlePlayerHit()}>Hit</Button>
							<Button variant="contained" disabled={!isPlayerTurn} onClick={() => {
								actions.nextActor()
							}}>Stand</Button>
						</div>
					</div>
				</section>
			</main>

			<Dialog
				open={isDialogOpen}
				onClose={() => {
					actions.resetGame()
					setIsDialogOpen(false)
				}}
			>
				<DialogTitle>
					You've lost!
				</DialogTitle>
				<DialogContent>
					<Typography className="mb-5">
						Your score is {playerScore}.
						To restart the game, click the button below
					</Typography>
					<div className="flex justify-center">
						<Button
							onClick={() => {
								actions.resetGame()
								actions.launchNewRound()
								setIsDialogOpen(false)
							}}
						>
							Restart
						</Button>
					</div>
				</DialogContent>
			</Dialog>
		</div>
	)
}

export default App
