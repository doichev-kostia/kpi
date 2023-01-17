import {Card} from "./card";
import {useGameStore} from "./store";
import {CardSuit, CardValue} from "./deck";
import React, {useState} from "react";
import {Button, Dialog, DialogContent, DialogTitle, Typography} from "@mui/material";
import {shallow} from "zustand/shallow";


function App() {
	const [isDialogOpen, setIsDialogOpen] = useState(false);
	const {bank, playerHand, computerHand, deck, actions} = useGameStore(({
																			  bank,
																			  playerHand,
																			  computerHand,
																			  deck,
																			  actions
																		  }) => ({
		bank,
		playerHand,
		computerHand,
		deck,
		actions
	}), shallow)

	const playerScore = actions.getScore('player');

	if (playerScore >= 21 && !isDialogOpen) {
		setIsDialogOpen(true);
	}

	console.log({isDialogOpen})


	return (
		<div className="grid grid-rows-[auto_1fr] bg-green-300 min-h-screen px-5">
			<header className="flex justify-between gap-4 py-4">
				<div>
					<h1>21 point game</h1>
				</div>
				<div>
					<p>Balance: {bank}</p>
				</div>
			</header>
			<main>
				<section>
					<button onClick={() => {
					actions.addCardToHand('player', actions.getLastDeckCard());
					}
					}>get card</button>
				</section>
				<section className="flex justify-center">
					<div className="max-w-md">
						<ul className="grid auto-cols-auto grid-flow-col gap-4">
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
					<Typography className="!mb-5">
						Your score is {playerScore}.
						To restart the game, click the button below
					</Typography>
					<div className="flex justify-center">
						<Button
							onClick={() => {
								actions.resetGame()
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
