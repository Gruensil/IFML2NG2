package ifml.generator.ng2.core

import java.io.File

class ParametersValidator {

	def Boolean validate(String[] args) {

		// Whether the correct number of parameters was passed
		if (args != null && args.length() == 2) {

			val validPaths = validatePaths(args.get(0), args.get(1));
			val validFiles = validateFiles(args.map[f|new File(f)]);

			if (validPaths && validFiles) {
				
				return true;
			}

			return false;

		} else {

			println("[ERROR] Not enough parameters. Please provide the absolute path to :\n- The IFML model.core\n- The output folder");
			return false;
		}

	}

	private def Boolean validatePaths (String pathToIFMLFile, String pathToOutputDir) {
		
		val paths = #[pathToIFMLFile, pathToOutputDir];
		
		if(paths.filter[path | path.replaceAll("\\s", "").length ==  0].length > 0) {
			
			println('''[ERROR] Provide non-empty pahts''');
			return false;
		}
		else if (paths.filter[path | path.startsWith("~")].length > 0) {
			
			println('''[ERROR] Provide absolute paths – i.e without tildes ('~')''')
			return false;
		}
		else if (!pathToIFMLFile.endsWith(ModelLoader.IFML_MODEL_FILE_EXTENSION)) {
			
			println("[ERROR] Provide a valid IFML file with .core extension");
			return false;	
		}
		else {
			
			return true;
		}
	}

	private def Boolean validateFiles(File[] files) {
		
		val invalidFiles = files.filter[f|!f.exists];

		if (!invalidFiles.nullOrEmpty) {

			val invalidPaths = invalidFiles.map[f|f.path].join(", ");
			println('''[ERROR] The resources pointed by the following paths don't exist: «invalidPaths»''')
			return false;

		} else {

			return true;

		}
	}

}
