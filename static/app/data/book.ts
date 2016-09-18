import { BookInfo } from './bookInfo';

export class Book {
    constructor(
        public id: number,
        public status: boolean,
        public bookInfo: BookInfo)
        {};
}
