import { BookLending } from './bookLending';
import {STUDENTS} from './mock-students';
import {BOOKS} from './mock-books';

export var BOOKLENDINGS: BookLending[] = [
    {lentBy: STUDENTS[1],lentBook: BOOKS[5],until:new Date(2016,10,31)}
];
