package ifml.generator.ng2.m2t.boilerplate.npm

import ifml.generator.ng2.m2t.general.AbstractFileGenerator

class NpmPackageGenerator extends AbstractFileGenerator<String> {

	override protected fileContents(String it) {
		'''
		{
		  "name": "«it»",
		  "version": "1.0.0",
		  "scripts": {
		    "start": "tsc && concurrently \"npm run tsc:w\" \"npm run lite\" ",
		    "lite": "lite-server",
		    "postinstall": "typings install",
		    "tsc": "tsc",
		    "tsc:w": "tsc -w",
		    "typings": "typings"
		  },
		  "license": "ISC",
		  "dependencies": {
		    "@angular/common": "2.0.0-rc.4",
		    "@angular/compiler": "2.0.0-rc.4",
		    "@angular/core": "2.0.0-rc.4",
		    "@angular/forms": "0.2.0",
		    "@angular/http": "2.0.0-rc.4",
		    "@angular/platform-browser": "2.0.0-rc.4",
		    "@angular/platform-browser-dynamic": "2.0.0-rc.4",
		    "@angular/router": "3.0.0-beta.1",
		    "@angular/router-deprecated": "2.0.0-rc.2",
		    "@angular/upgrade": "2.0.0-rc.4",
		    "angular2-in-memory-web-api": "0.0.14",
		    "bootstrap": "^3.3.6",
		    "core-js": "^2.4.0",
		    "jquery": "2.2.4",
		    "mobile-detect": "^1.3.3",
		    "nools": "^0.4.1",
		    "reflect-metadata": "^0.1.3",
		    "responsive-directives-angular2": "^0.3.0",
		    "rxjs": "5.0.0-beta.6",
		    "systemjs": "0.19.27",
		    "zone.js": "^0.6.12"
		  },
		  "devDependencies": {
		    "concurrently": "^2.0.0",
		    "lite-server": "^2.2.0",
		    "typescript": "^1.8.10",
		    "typings": "^1.0.4"
		  }
		}
		'''
	}

	override protected fileName(String it) {
		
		'''package.json'''
	}

	override protected folderName(String it) {
		// placed in root
		'''/'''
	}

}
