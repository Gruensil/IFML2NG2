		// PROTECTED REGION ID _UloJQIC_Eea2S59Os6LSKA.getLentBooksBinding ENABLED START
		this._dataService.getLendings(this._authenticationService.getId()).then(lendings => this.lentBooksBinding = lendings);
		// PROTECTED REGION END