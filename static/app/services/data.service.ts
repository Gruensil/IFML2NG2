	import { Injectable, OnInit } from '@angular/core';

import { Book } from '../data/book';
import { Student } from '../data/student';
import { BookLending } from '../data/bookLending';
import { BookReservation } from '../data/bookReservation';

import { BOOKS } from '../data/mock-books';
import { BOOKLENDINGS } from '../data/mock-bookLendings';
import { BOOKRESERVATIONS } from '../data/mock-bookReservations';
import { STUDENTS } from '../data/mock-students';

declare var $: any;

@Injectable()
export class DataService {

  constructor(){
      if(localStorage.getItem('booklendings') === null){
        localStorage.setItem('booklendings', JSON.stringify(BOOKLENDINGS));
      }
      if(localStorage.getItem('bookreservations') === null){
        localStorage.setItem('bookreservations', JSON.stringify(BOOKRESERVATIONS));
      }
      if(localStorage.getItem('books') === null){
        localStorage.setItem('books', JSON.stringify(BOOKS));
      }
    }

// Get / Set operations

  localGet(key: string){
    return JSON.parse(localStorage.getItem(key));
  }

  localSet(key: string, data){
    return localStorage.setItem(key, JSON.stringify(data));
  }

  getLendings(id: string) {
    return Promise.resolve(this.localGet('booklendings').filter(l => l.lentBy.studentId == id));
  }

  getBooks() {
    return Promise.resolve(this.localGet('books'));
  }

  getBooksSync() {
    return this.localGet('books');
  }

  getBookById(id:string){
    return Promise.resolve(this.getBooks().then(books => books.find(b => b.bookId == id)));
  }

  getBookByIdSync(id:string){
    return this.getBooksSync().find(b => b.bookId == id);
  }

  getBookReservations(){
    return Promise.resolve(this.localGet('bookreservations'));
  }

  getStudents() {
    return Promise.resolve(STUDENTS);
  }

  getStudentById(id:string){
    return Promise.resolve(STUDENTS.find(s => s.studentId == id));
  }

  getStudentByIdSync(id:string){
    return STUDENTS.find(s => s.studentId == id);
  }

// Actions

  reserveBook(bookId: string, studentId: string){
    var bookObj: Book;
    var studentObj: Student;
    var br: BookReservation;
    var brs: BookReservation[];

    bookObj = this.getBookByIdSync(bookId);
    studentObj = this.getStudentByIdSync(studentId);

    br = {reservedBook:bookObj, reservedBy: studentObj};
    brs = this.localGet('bookreservations');
    brs.push(br);
    this.localSet('bookreservations', brs);

    this.updateBookStatus(bookId, false);
  }

  returnBook(id:string){
    var bl: BookLending;
    var br: BookReservation;

    console.log(this.localGet('bookreservations'));
    console.log(this.localGet('booklendings'));
    bl = this.localGet('booklendings').find(bl => bl.lentBook.bookId == id);
    if(bl != null){
      var index2 = this.indexOfLending(this.localGet('booklendings'),bl);

      this.localSplice('booklendings', index2);
    }

    br = this.localGet('bookreservations').find(bl => bl.reservedBook.bookId == id);
    if(br != null){
      var index2 = this.indexOfReservation(this.localGet('bookreservations'),br);
      console.log('index2 ' + index2);

      this.localSplice('bookreservations', index2);
    }

    this.updateBookStatus(id, true);
  }

  lendBook(bookObj:Book, studentId: string, until: Date){
    var tempArr: BookLending[];
    var student: Student;
    var book: Book;
    var br: BookReservation;
    var bookreservations: BookReservation[];

    book = this.getBookByIdSync(bookObj.bookId);
    bookreservations = this.localGet('bookreservations');

    if(book.bookStatus === true || bookreservations.find(bl => bl.reservedBook.bookId == bookObj.bookId && bl.reservedBy.studentId == studentId) != null)
    {
      tempArr = this.localGet('booklendings');
      student = this.getStudentByIdSync(studentId);
      tempArr.push(new BookLending(until,bookObj,student));
      this.localSet('booklendings', tempArr);

      br = bookreservations.find(bl => bl.reservedBook.bookId == bookObj.bookId && bl.reservedBy.studentId == studentId);
      if(br != null){
        var index2 = this.indexOfReservation(bookreservations,br);

        this.localSplice('bookreservations', index2);
      }

      this.updateBookStatus(bookObj.bookId, false);
    }
  }

// Helper methods

  updateBookStatus(id:string, status:boolean){
    var books: Book[];
    books = this.getBooksSync();
	$.each(books, function() {
		if (this.bookId == id) {
			this.bookStatus = status;
		}
	});
    this.localSet('books', books);
  }

  localSplice(key:string, index: number){
    if(index > -1){
        var tempArr = this.localGet(key);
        tempArr.splice(index,1);
        this.localSet(key, tempArr);
    }
  }

  indexOfReservation(array, item) {
    for (var i = 0; i < array.length; i++) {
      var tempBook: BookReservation;
      var tempBook2: BookReservation;
      tempBook = array[i];
      tempBook2 = item;
      if (tempBook.reservedBook.bookId == tempBook2.reservedBook.bookId && tempBook.reservedBy.studentId == tempBook2.reservedBy.studentId) return i;
    }
    return -1;
  }

  indexOfLending(array, item) {
    for (var i = 0; i < array.length; i++) {
      var tempBook: BookLending;
      var tempBook2: BookLending;
      tempBook = array[i];
      tempBook2 = item;
      if (tempBook.lentBook.bookId == tempBook2.lentBook.bookId) return i;
    }
    return -1;
  }
}
