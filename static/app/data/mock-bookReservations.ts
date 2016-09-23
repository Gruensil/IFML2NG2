import { BookReservation } from './bookReservation';
import {STUDENTS} from './mock-students';
import {BOOKS} from './mock-books';

export var BOOKRESERVATIONS: BookReservation[] = [
    {reservedBy: STUDENTS[1],reservedBook: BOOKS[0]},
    {reservedBy: STUDENTS[0],reservedBook: BOOKS[1]},
    {reservedBy: STUDENTS[2],reservedBook: BOOKS[3]},
];
