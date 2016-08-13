package ifml.generator.ng2.core

import java.util.ArrayList
import java.io.File
import com.google.common.io.Files
import java.io.IOException
import com.google.common.base.Charsets
import java.nio.file.Paths
import ifml.generator.ng2.m2t.utils.Interceptor

class FileManager {
	
	private static FileManager INSTANCE
	private String _pathToOutputDirectory
	private ArrayList<File> _termporaryFiles
	
	static def FileManager sharedInstance(){
		
		if(INSTANCE == null) {
			
			INSTANCE = new FileManager();
			INSTANCE._pathToOutputDirectory = new String()
			INSTANCE._termporaryFiles = new ArrayList<File>()
		}
		
		return INSTANCE;
	}

	def registerPathToOutputDirectory(String pathToOutputFolder) {
	
		_pathToOutputDirectory = pathToOutputFolder;
		if(!_pathToOutputDirectory.endsWith("/")) {
			_pathToOutputDirectory += "/"
		}
	}

	def String registerPathToInputFile(String pathToInputFile) {

		val inputFile = new File(pathToInputFile);
		val localFile = new File(inputFile.getName());

		try {

			Files::copy(inputFile, localFile);
			_termporaryFiles.add(localFile);

		} catch (IOException e) {
			
			println('''[ERROR] File «pathToInputFile» could not be copied''')
		}

		return localFile.getName();
	}

	def generateFile(String fileName, String contents) {

		/*val file = new File(this._pathToOutputDirectory + fileName);

		try {

			Files::createParentDirs(file);
			Files::write(contents.getBytes(Charsets.UTF_8), file);

		} catch (IOException e) {

			println('''[ERROR] File «fileName» could not be created''');
		}*/
		Interceptor::sharedInstance.generateFile(this._pathToOutputDirectory + fileName, contents);

	}

	def generateFileAtRootParent(String fileName, String contents) {

		val path = Paths::get(_pathToOutputDirectory);
		val file = new File(path.getParent() + "/" + fileName);

		try {

			Files::createParentDirs(file);
			Files::write(contents.getBytes(Charsets.UTF_8), file);

		} catch (IOException e) {

			println('''[ERROR] File «fileName» could not be created''');
		}
	}

	def close() {
		
		_termporaryFiles.forEach[delete]
	}
	
}