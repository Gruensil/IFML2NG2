			// PROTECTED REGION ID _emQWIIC-Eea2S59Os6LSKA.loginAction ENABLED START
			if(this._authenticationService.login(this.username, this.password)){
				this._router.navigate(['searchBooks']);
			}
			// PROTECTED REGION END