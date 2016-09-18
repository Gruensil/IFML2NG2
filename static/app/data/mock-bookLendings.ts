import { BookLending } from './bookLending';
import {STUDENTS} from './mock-students';
import {BOOKS} from './mock-books';

export var BOOKLENDINGS: BookLending[] = [
    {student: STUDENTS[1],book: BOOKS[5],until:new Date(2016,10,31)}
];
