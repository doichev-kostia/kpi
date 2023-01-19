import React from 'react';
import cx from 'classnames';
import './card.css';
import {CardSuit, CardValue} from "./deck";


interface CardProps {
	value: CardValue;
	suit: CardSuit;
	faceUp?: boolean;
	className?: string;
}

export const Card = ({value, suit, faceUp = false, className}: CardProps) => {

	const valueAsNumber = parseInt(value);
	const isFaceCardValue = Number.isNaN(valueAsNumber);

	return (
		<div className={cx('card', !faceUp && 'bg-gray-500', className)} data-value={value} data-suit={suit}>
			{faceUp && (
				<>
					{
						isFaceCardValue ? (
							<div className="card__pip"></div>
						) : (
							new Array(parseInt(value)).fill(0).map((_, i) => (
								<div key={i} className="card__pip"></div>
							))
						)
					}
					<div className={cx('card__corner-number', "top-1 left-1")}>{value}</div>
					<div className={cx('card__corner-number', "bottom-1 right-1 rotate-180")}>{value}</div>
				</>
			)}
		</div>
	);
};
