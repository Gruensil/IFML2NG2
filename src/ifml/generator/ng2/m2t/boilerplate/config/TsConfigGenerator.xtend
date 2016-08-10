package ifml.generator.ng2.m2t.boilerplate.config

import ifml.generator.ng2.m2t.general.AbstractFileGenerator

class TsConfigGenerator extends AbstractFileGenerator<String> {

	override protected fileContents(String it) {

		'''
		{
		  "compilerOptions": {
		    "target": "es5",
		    "module": "commonjs",
		    "moduleResolution": "node",
		    "sourceMap": true,
		    "emitDecoratorMetadata": true,
		    "experimentalDecorators": true,
		    "removeComments": false,
		    "noImplicitAny": false
		  }
		}
		'''
	}

	override protected fileName(String it) {
		
		'''tsconfig.json'''
	}

	override protected folderName(String it) {
		// placed in root
		'''/'''
	}

}
