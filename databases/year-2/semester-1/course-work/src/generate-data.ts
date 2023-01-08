import {faker} from "@faker-js/faker";
import {randomUUID} from "node:crypto"
import {Address, Cinema, Movie, Price, Product, Room, Seat, seatType, Event, Ticket, Order, OrderItem} from "./types";
import * as path from "path";
import * as fs from "fs";

const milliseconds = {
    second: 1000,
    minute: 1000 * 60,
    hour: 1000 * 60 * 60,
}

const seconds = {
    minute: 60,
    hour: 60 * 60,
}

const NUMBER_OF_EVENTS = 100;

const NUMBER_OF_CINEMAS = 5;

const NUMBER_OF_MOVIES = 10;

const NUMBER_OF_ROOMS_PER_CINEMA = 3;

const NUMBER_OF_SEATS_PER_ROOM = 100;

const TICKETS_PER_ORDER = 5;
const PRODUCTS_PER_ORDER = 3;

const getRandomInt = (min: number, max: number) => {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

const addresses = new Array(NUMBER_OF_CINEMAS).fill(0).map<Address>(() => {
    const houseNumber = (() => {
        const number = faker.address.buildingNumber();
        if (number.length > 15) return number.substring(0, 15);
        return number;
    })();
    return {
        id: randomUUID(),
        country: faker.address.country(),
        city: faker.address.city(),
        street: faker.address.streetName(),
        houseNumber,
        index: faker.address.zipCode("#####"),
    };
});

console.log("Generated addresses");

const cinemas = new Array(NUMBER_OF_CINEMAS).fill(0).map<Cinema>((_, index) => {
    return {
        id: randomUUID(),
        name: faker.company.name(),
        addressId: addresses[index].id,
        phoneNumber: faker.phone.number(),
        email: faker.internet.email(),
    };
});

console.log("Generated cinemas");

const rooms: Room[] = [];
for (let i = 0; i < NUMBER_OF_CINEMAS; i++) {
    for (let j = 0; j < NUMBER_OF_ROOMS_PER_CINEMA; j++) {
        rooms.push({
            id: randomUUID(),
            name: faker.company.name(),
            cinemaId: cinemas[i].id,
        });
    }
}

console.log("Generated rooms");

const seats: Seat[] = [];
for (let i = 0; i < rooms.length; i++) {
    for (let seatIndex = 0; seatIndex < NUMBER_OF_SEATS_PER_ROOM; seatIndex++) {
        seats.push({
            id: randomUUID(),
            roomId: rooms[i].id,
            row: getRandomInt(1, 10),
            number: getRandomInt(1, 10),
            type: seatType[getRandomInt(0, seatType.length - 1)],
        });
    }
}

console.log("Generated seats");

const movies = new Array(NUMBER_OF_MOVIES).fill(0).map<Movie>((_, index) => {
    const releaseDate = index > 5 ? faker.date.recent(30) : faker.date.soon(5);
    return {
        id: randomUUID(),
        title: faker.company.name(),
        description: faker.lorem.paragraph(),
        duration: getRandomInt(1.5 * seconds.hour, 3 * seconds.hour),
        releaseDate: releaseDate.toISOString(),
        rating: getRandomInt(1, 10),
        genres: faker.lorem.words(3),
        directors: faker.name.fullName(),
        actors: new Array(5).fill(0).map(() => faker.name.fullName()).join(", "),
        posterUrl: faker.image.imageUrl(),
    }
});

console.log("Generated movies");

const prices: Price[] = [];

for (let i = 0; i < movies.length; i++) {
    for (let j = 0; j < seatType.length; j++) {
        prices.push({
            id: randomUUID(),
            movieId: movies[i].id,
            seatType: seatType[j],
            // cents
            price: getRandomInt(1500, 10_000),
            currency: "USD",
        });
    }
}

console.log("Generated prices");

const products = new Array(20).fill(0).map<Product>(() => {
    return {
        id: randomUUID(),
        name: faker.commerce.productName(),
        // cents
        price: getRandomInt(100, 100_000),
    }
});

console.log("Generated products");

const events: Event[] = [];
for (let i = 0; i < NUMBER_OF_EVENTS; i++) {
    const movie = movies[getRandomInt(0, movies.length - 1)];
    const room = rooms[getRandomInt(0, rooms.length - 1)];
    const releaseDate = new Date(movie.releaseDate);
    const startsAt = faker.date.soon(30, releaseDate);
    const endsAt = new Date(startsAt.getTime() + movie.duration * milliseconds.second);
    events.push({
        id: randomUUID(),
        movieId: movie.id,
        roomId: room.id,
        startsAt: startsAt.toISOString(),
        endsAt: endsAt.toISOString(),
    });
}

console.log("Generated events");

const tickets: Ticket[] = [];

for (let i = 0; i < events.length; i++) {
    const seatsForEvent = seats.filter(seat => seat.roomId === events[i].roomId);
    for (let seatIndex = 0; seatIndex < seatsForEvent.length; seatIndex++) {
        const seat = seatsForEvent[seatIndex];
        const price = prices.find(price => price.movieId === events[i].movieId && price.seatType === seat.type);
        tickets.push({
            id: randomUUID(),
            eventId: events[i].id,
            seatId: seat.id,
            price: price?.price || getRandomInt(1500, 10_000),
        });
    }
}

console.log("Generated tickets");

const customers = new Array(100).fill(0).map(() => {
    return {
        id: randomUUID(),
        firstName: faker.name.firstName(),
        lastName: faker.name.lastName(),
        email: faker.internet.email(),
        phoneNumber: faker.phone.number(),
        password: faker.internet.password(),
    }
});

console.log("Generated customers");

const orders: Order[] = [];
const orderItems: OrderItem[] = [];
const numberOfOrders = tickets.length / TICKETS_PER_ORDER;
let ticketOffset = 0;

for (let i = 0; i < numberOfOrders; i++) {
    // 75% of chance to be false
    const isAnonymous = getRandomInt(0, 3) !== 0;

    const customer = isAnonymous ? undefined : customers[getRandomInt(0, customers.length - 1)];

    const order: Partial<Order> = {
        id: randomUUID(),
        customerId: customer ? customer.id : undefined,
    };

    const currentOrderItems: OrderItem[] = [];


    for (let j = 0; j < TICKETS_PER_ORDER; j++) {
        const ticket = tickets[ticketOffset + j];
        if (!ticket) {
            break;
        }
        currentOrderItems.push({
            id: randomUUID(),
            orderId: order.id as string,
            ticketId: ticket.id,
            quantity: 1,
        });
        ticketOffset += 1;
    }
    for (let j = 0; j < PRODUCTS_PER_ORDER; j++) {
        const product = products[getRandomInt(0, products.length - 1)];
        currentOrderItems.push({
            id: randomUUID(),
            orderId: order.id as string,
            productId: product.id,
            quantity: getRandomInt(1, 5),
        });
    }
    order.price = currentOrderItems.reduce((acc, item) => {
        if (item.ticketId) {
            const ticket = tickets.find(ticket => ticket.id === item.ticketId);
            return acc + (ticket?.price || 0);
        } else {
            const product = products.find(product => product.id === item.productId);
            return acc + (product?.price || 0);
        }
    }, 0);
    orders.push(order as Order);
    orderItems.push(...currentOrderItems);
}

const root = path.resolve(__dirname, "..");
const outFile = path.resolve(root, "scripts", "data", "data.sql");

const toTimestamp = (isoDate: string) => {
    return `to_timestamp('${isoDate}', 'YYYY-MM-DD"T"HH24:MI:SS.FF3"Z"')::timestamp`;
}

const formatQuotes = (str: string) => {
    return str.replace(/'/g, "''");
}

console.log(toTimestamp(new Date().toISOString()));

const addressSql = `INSERT INTO "address" ("id", "country", "city", "street", "house_number", "index") VALUES ${addresses.map(address => `('${address.id}', '${formatQuotes(address.country)}', '${formatQuotes(address.city)}', '${formatQuotes(address.street)}', '${address.houseNumber}', '${address.index}')`).join(", ")};`;
const cinemaSql = `INSERT INTO "cinema" ("id", "name", "address_id", "phone_number", "email") VALUES ${cinemas.map(cinema => `('${cinema.id}', '${formatQuotes(cinema.name)}', '${cinema.addressId}', '${cinema.phoneNumber}', '${cinema.email}')`).join(", ")};`;
const roomSql = `INSERT INTO "room" ("id", "cinema_id", "name") VALUES ${rooms.map(room => `('${room.id}', '${room.cinemaId}', '${formatQuotes(room.name)}')`).join(", ")};`;
const seatSql = `INSERT INTO "seat" ("id", "room_id", "row", "number", "type") VALUES ${seats.map(seat => `('${seat.id}', '${seat.roomId}', ${seat.row}, ${seat.number}, '${seat.type}')`).join(", ")};`;
const movieSql = `INSERT INTO "movie" ("id", "title", "description", "duration", "release_date", "rating", "genres", "directors", "actors", "poster_url") VALUES ${movies.map(movie => `('${movie.id}', '${formatQuotes(movie.title)}', '${formatQuotes(movie.description)}', ${movie.duration}, ${toTimestamp(movie.releaseDate)}, ${movie.rating}, '${formatQuotes(movie.genres)}', '${formatQuotes(movie.directors)}', '${formatQuotes(movie.actors)}', '${movie.posterUrl}')`).join(", ")};`;
const priceSql = `INSERT INTO "price" ("id", "movie_id", "seat_type", "price", "currency") VALUES ${prices.map(price => `('${price.id}', '${price.movieId}', '${price.seatType}', ${price.price}, '${price.currency}')`).join(", ")};`;
const productSql = `INSERT INTO "product" ("id", "name", "price") VALUES ${products.map(product => `('${product.id}', '${formatQuotes(product.name)}', ${product.price})`).join(", ")};`;
const eventSql = `INSERT INTO "event" ("id", "movie_id", "room_id", "starts_at", "ends_at") VALUES ${events.map(event => `('${event.id}', '${event.movieId}', '${event.roomId}', ${toTimestamp(event.startsAt)}, ${toTimestamp(event.endsAt)})`).join(", ")};`;
const ticketSql = `INSERT INTO "ticket" ("id", "event_id", "seat_id", "price") VALUES ${tickets.map(ticket => `('${ticket.id}', '${ticket.eventId}', '${ticket.seatId}', ${ticket.price})`).join(", ")};`;
const customerSql = `INSERT INTO "customer" ("id", "first_name", "last_name", "phone_number", "email", "password") VALUES ${customers.map(customer => `('${customer.id}', '${formatQuotes(customer.firstName)}', '${formatQuotes(customer.lastName)}', '${customer.phoneNumber}', '${customer.email}', '${customer.password}')`).join(", ")};`;
const orderSql = `INSERT INTO "order" ("id", "customer_id", "price") VALUES ${orders.map(order => `('${order.id}', ${order.customerId ? `'${order.customerId}'` : "NULL"}, ${order.price})`).join(", ")};`;
const orderItemSql = `INSERT INTO "order_item" ("id", "order_id", "ticket_id", "product_id", "quantity") VALUES ${orderItems.map(orderItem => `('${orderItem.id}', '${orderItem.orderId}', ${orderItem.ticketId ? `'${orderItem.ticketId}'` : "NULL"}, ${orderItem.productId ? `'${orderItem.productId}'` : "NULL"}, ${orderItem.quantity})`).join(", ")};`;

const sql = `-- Automatically generated data
-- Addresses
${addressSql}


-- Cinemas
${cinemaSql}


-- Rooms
${roomSql}


-- Seats
${seatSql}


-- Movies
${movieSql}


-- Prices
${priceSql}


-- Products
${productSql}


-- Events
${eventSql}


-- Tickets
${ticketSql}


-- Customers
${customerSql}


-- Orders
${orderSql}


-- Order items
${orderItemSql}`;

fs.writeFileSync(outFile, sql);
