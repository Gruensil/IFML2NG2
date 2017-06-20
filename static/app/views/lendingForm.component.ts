			// PROTECTED REGION ID _vV7RQIDmEea8AL0yBf-zEA.issueBookAction ENABLED START
			if(this.selectedBookToIssueBinding != null){
				this._dataService.lendBook(this.selectedBookToIssueBinding, this.studentID, this.dueDate);
			}else if(this.selectedReservationBinding != null){
				this._dataService.lendBook(this.selectedReservationBinding.reservedBook, this.studentID, this.dueDate);
			}
    		this.bookISBN = '';
			this.studentID = '';	
			// PROTECTED REGION END

		// PROTECTED REGION ID _mnIcUIC-Eea2S59Os6LSKA.ngOnInit ENABLED START
		if(this.selectedBookToIssueBinding != null){
			this.bookISBN = this.selectedBookToIssueBinding.bookInfo.isbn;
		}else if(this.selectedReservationBinding != null){
			this.bookISBN = this.selectedReservationBinding.reservedBook.bookInfo.isbn;
			this.studentID = this.selectedReservationBinding.reservedBy.studentId;
		}		
		this.dueDate = new Date();
    	this.dueDate.setDate( this.dueDate.getDate() + 30 );
		// PROTECTED REGION END        