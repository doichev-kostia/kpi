export const seatType = ['standard', 'premium', 'luxury'] as const;
export type SeatType = typeof seatType[number];

export type Address = {
    id: string;
    country: string;
    city: string;
    street: string;
    houseNumber: string;
    index: string;
}

export type Cinema = {
    id: string;
    name: string;
    addressId: string;
    phoneNumber: string;
    email: string;
}

export type Room = {
    id: string;
    name: string;
    cinemaId: string;
}

export type Seat = {
    id: string;
    roomId: string;
    row: number;
    number: number;
    type: SeatType;
}

export type Movie = {
    id: string;
    title: string;
    description: string;
    duration: number;
    releaseDate: string;
    rating: number;
    genres: string;
    directors: string;
    actors: string;
    posterUrl: string;
}

export type Price = {
    id: string;
    movieId: string;
    seatType: SeatType;
    price: number;
    currency: string;
}

export type Event = {
    id: string;
    movieId: string;
    roomId: string;
    startsAt: string;
    endsAt: string;
}

export type Ticket = {
    id: string;
    eventId: string;
    seatId: string;
    price: number;
}

export type Product = {
    id: string;
    name: string;
    price: number;
}

export type Order = {
    id: string;
    customerId: string;
    price: number;
}

export type OrderItem = {
    id: string;
    orderId: string;
    ticketId?: string;
    productId?: string;
    quantity: number;
}

export type Customer = {
    id: string;
    firstName: string;
    lastName: string;
    phoneNumber: string;
    email: string;
    password: string;
}
