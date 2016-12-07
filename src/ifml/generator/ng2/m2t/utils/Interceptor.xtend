package ifml.generator.ng2.m2t.utils

import java.io.File
import com.google.common.io.Files
import com.google.common.base.Charsets
import java.io.IOException
import java.io.FileNotFoundException

class Interceptor{
	
	private static Interceptor INSTANCE
	private File file;
	
	static def Interceptor sharedInstance(){
		
		if(INSTANCE == null) {
			
			INSTANCE = new Interceptor();
		}
		
		return INSTANCE;
	}
	
	def generateFile(String filepath, String contents){
		
		this.file = new File(filepath);

		try{
			this.writeContentsToFile(replaceProtectedRegions(contents));
		}catch(FileNotFoundException e){
			println('''[WARNING] File «file.name» does not exist. Protected Regions could not be replaced.''');
			this.writeContentsToFile(contents);
		}
		
	}
	
	private def String replaceProtectedRegions(String contents){
		
		var tempContents = contents
		val lines = Files::readLines(file,Charsets.UTF_8);
		
		for (var i = 0; i < lines.length; i++){
			
			if(lines.get(i).contains("// PROTECTED REGION ID") && lines.get(i).contains("ENABLED START")){

				// found start of protected region
				var protectedRegionContent = "";
				var regionStart = lines.get(i).toString();
				
				do{
					
					protectedRegionContent += lines.get(i).toString() +"\n";	
					i++;
						
				}while(!lines.get(i).contains("// PROTECTED REGION END"));
				
				// cut off last '\n'
				protectedRegionContent = protectedRegionContent.subSequence(0,protectedRegionContent.length-1).toString();
			
				tempContents = tempContents.replace(regionStart, protectedRegionContent);
				
			}
			
		}
		
		return tempContents;
	}
	
	private def writeContentsToFile(String contents){
		try {

			Files::createParentDirs(file);
			//Files::write(contents.getBytes(Charsets.UTF_8), file);
			Files::write(contents.getBytes(Charsets.UTF_8), file);

		} catch (IOException e) {

			println('''[ERROR] File «file.name» could not be created''');
		}
	}
}