			// PROTECTED REGION ID _A2qEQIC_Eea2S59Os6LSKA.reserveBookAction ENABLED START
			this._dataService.reserveBook(this.selectedBookBinding.bookId, this._authenticationService.getId());
    		this.getBookBinding();
			// PROTECTED REGION END

            // PROTECTED REGION ID _IaebAIC_Eea2S59Os6LSKA.returnBookAction ENABLED START
			this._dataService.returnBook(this.selectedBookBinding.bookId);
    		this.getBookBinding();
			// PROTECTED REGION END

		// PROTECTED REGION ID _sU8p0IC1Eea2S59Os6LSKA.getBookBinding ENABLED START
		this._dataService.getBooks().then(lendings => this.bookBinding = lendings)
		// PROTECTED REGION END