package ifml.generator.ng2.m2t.dynamic.app.context;

import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import org.w3c.dom.NodeList
import java.util.HashMap
import ifml.generator.ng2.m2t.utils.ServiceCollection

public class ContextManagerServiceGenerator extends AbstractFileGenerator<Document> {
	
	public def generateFile() {
		
	}
	
	def generateCode(NodeList actionNodeList, HashMap serviceMap, HashMap functionMap){
		return generateTemplate(actionNodeList, serviceMap, functionMap);
	}
	
	override protected fileContents(Document it) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override protected fileName(Document it) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override protected folderName(Document it) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}