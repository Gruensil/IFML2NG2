package ifml.generator.ng2

import ifml.generator.ng2.core.ParametersValidator
import ifml.generator.ng2.core.FileManager
import ifml.generator.ng2.core.ModelLoader
import ifml.generator.ng2.core.ModelValidator
import ifml.generator.ng2.core.CodeGenerator
import java.io.InputStream

class Main {

	def static void main(String[] args){

		// whether the received parameters point to valid resources
		if(new ParametersValidator().validate(args)){
			
			// Prepare the File Manager & register input PATHS
			val fileManager = FileManager::sharedInstance;
			fileManager.registerPathToOutputDirectory(args.get(3));
			val pathToAdaptFile = fileManager.registerPathToInputFile(args.get(1));
			val pathToIFMLFile = fileManager.registerPathToInputFile(args.get(0));

			// Load the Models
			val modelLoader = new ModelLoader;
			println(pathToAdaptFile);
			val ifmlModel = modelLoader.loadIFMLModel(pathToIFMLFile);
			val adaptModel = modelLoader.loadAdaptModel(args.get(1))
			
			// copy files
			fileManager.copyFiles(args.get(2), args.get(3));
			//var xsd = "C:\\Users\\STAH037\\workspace\\IFML2NG2\\data\\adapt.xsd";
			var xsd = "C:\\Users\\Hagen\\workspaceNeon\\IFML2NG2\\data\\adapt.xsd";
			// Whether the loaded IFML model can be transformed by the generation tool
			if(new ModelValidator().validate(ifmlModel) && new ModelValidator().validateAdaptFile(adaptModel, xsd)){
				
				new CodeGenerator().generateCode(ifmlModel, adaptModel);
				println("M2T IFML2NG2 finished!")
				
			}

		}	
		
	}

}