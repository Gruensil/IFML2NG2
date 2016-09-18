import { BookReservation } from './bookReservation';
import {STUDENTS} from './mock-students';
import {BOOKS} from './mock-books';

export var BOOKRESERVATIONS: BookReservation[] = [
    {student: STUDENTS[1],book: BOOKS[0]},
    {student: STUDENTS[0],book: BOOKS[1]},
    {student: STUDENTS[2],book: BOOKS[3]},
];
