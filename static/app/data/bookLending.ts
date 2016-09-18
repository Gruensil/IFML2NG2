import { Book } from './book';
import { Student } from './student';

export class BookLending {
    constructor(
    public book: Book,
    public student: Student,
    public until: Date)
    {
    };
}

