package ifml.generator.ng2

import ifml.generator.ng2.core.ParametersValidator
import ifml.generator.ng2.core.FileManager
import ifml.generator.ng2.core.ModelLoader
import ifml.generator.ng2.core.ModelValidator
import ifml.generator.ng2.core.CodeGenerator

class Main {

	def static void main(String[] args){

		// whether the received parameters point to valid resources
		if(new ParametersValidator().validate(args)){
			
			// Prepare the File Manager & register input PATHS
			val fileManager = FileManager::sharedInstance;
			fileManager.registerPathToOutputDirectory(args.get(1));
			val pathToIFMLFile = fileManager.registerPathToInputFile(args.get(0));

			// Load the Models
			val modelLoader = new ModelLoader;
			val ifmlModel = modelLoader.loadIFMLModel(pathToIFMLFile);
			
			// Whether the loaded IFML model can be transformed by the generation tool
			if(new ModelValidator().validate(ifmlModel)){
				
				new CodeGenerator().generateCode(ifmlModel);
				println("M2T IFML2NG2 finished!")
				
			}

		}	
		
	}

}