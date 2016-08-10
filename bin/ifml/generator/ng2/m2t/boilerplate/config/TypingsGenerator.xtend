package ifml.generator.ng2.m2t.boilerplate.config

import ifml.generator.ng2.m2t.general.AbstractFileGenerator

class TypingsGenerator extends AbstractFileGenerator<String> {

	override protected fileContents(String it) {

		'''
		{
		  "globalDependencies": {
		    "core-js": "registry:dt/core-js#0.0.0+20160602141332",
		    "jasmine": "registry:dt/jasmine#2.2.0+20160621224255",
		    "node": "registry:dt/node#6.0.0+20160621231320"
		  }
		}
		'''
	}

	override protected fileName(String it) {
		
		'''typings.json'''
	}

	override protected folderName(String it) {
		// placed in root
		'''/'''
	}

}
