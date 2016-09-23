package ifml.generator.ng2.m2t.dynamic.app.data

import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import org.eclipse.uml2.uml.internal.impl.ClassImpl
import org.eclipse.uml2.uml.internal.impl.PrimitiveTypeImpl

class ExportClassGenerator extends AbstractFileGenerator<ClassImpl> {	
		
	// Overridden Parent methods
	override protected fileContents(ClassImpl it) {
		var body = '''''';
		var header = '''''';
		
		body += '''
		
		export class «it.name.toFirstUpper» {
			constructor(
		'''
		
		for(attr: it.attributes){
			body += '''		public «attr.name»: '''
			if(!(attr.type instanceof PrimitiveTypeImpl)){
				body += '''«attr.type.name»,'''
				header += '''
					import { «attr.type.name.toFirstUpper» } from './«attr.type.name.toFirstLower»';
				'''
			}else{
				if(attr.type.toString.contains("#String")){
					body += '''string,'''
				}else if (attr.type.toString.contains("#Boolean")){
					body += '''boolean,'''
				}else if (attr.type.toString.contains("#Int")){
					body += '''number,'''
				}else{
					body += '''any,'''
				}
			}
			body+= '''
			
			'''
		}
			body = body.substring(0,body.lastIndexOf(','));
			body+= '''
			
			'''
		
				/*«FOR attr: it.attributes»
					public «attr.name»: «IF (attr.type != null)»«attr.type.name»;«ENDIF»
				«ENDFOR»*/
				
		body += '''
			){};
		}
		'''
		
		return header + body;
	}
	
	override protected fileName(ClassImpl it) {
		'''«it.name.toFirstLower».ts'''
	}

	override protected folderName(ClassImpl it) {
		"app/data/"
	}
}
