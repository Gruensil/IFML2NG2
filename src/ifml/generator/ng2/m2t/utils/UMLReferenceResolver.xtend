package ifml.generator.ng2.m2t.utils

import org.eclipse.uml2.uml.Model
import org.eclipse.emf.ecore.impl.EStoreEObjectImpl
import org.eclipse.emf.common.util.URI
import org.eclipse.uml2.uml.internal.impl.PropertyImpl
import org.eclipse.uml2.uml.StructuralFeature
import java.util.ArrayList
import org.w3c.dom.Document
import org.eclipse.uml2.uml.internal.impl.PrimitiveTypeImpl
import org.eclipse.uml2.uml.internal.impl.ClassImpl

class UMLReferenceResolver{
	
	private static UMLReferenceResolver INSTANCE
	private Model MODEL
	private Document DOCUMENT
	
	ArrayList<String> output
	
	static def UMLReferenceResolver sharedInstance(){
		
		if(INSTANCE == null) {
			
			INSTANCE = new UMLReferenceResolver();
		}
		
		return INSTANCE;
	}
	
	def setUMLModel(Model m){
		MODEL = m;
	}
	
	def setUMLDocument(Document d){
		DOCUMENT = d;
	}
	
	// Returns name of domain concept
	def ArrayList<String> getOwnedAttributesLong(StructuralFeature struct){
		output = new ArrayList<String>();
		
		for( attr : struct.type.ownedElements){
			if((attr as PropertyImpl).type instanceof PrimitiveTypeImpl){
				output.add(struct.name + "." + (attr as PropertyImpl).name)
			}else if((attr as PropertyImpl).type instanceof ClassImpl){
				for( attr2 : (attr as PropertyImpl).type.ownedElements){
					output.add(struct.name + "." + (attr as PropertyImpl).name + "."+ (attr2 as PropertyImpl).name)
				}
			}
		}
		
		return output;
	}
	
		// Returns name of domain concept
	def ArrayList<String> getOwnedAttributesShort(StructuralFeature struct){
		output = new ArrayList<String>();
		
		for( attr : struct.type.ownedElements){
			if((attr as PropertyImpl).type instanceof PrimitiveTypeImpl){
				output.add((attr as PropertyImpl).name)
			}else if((attr as PropertyImpl).type instanceof ClassImpl){
				for( attr2 : (attr as PropertyImpl).type.ownedElements){
					output.add((attr2 as PropertyImpl).name)
				}
			}
		}
		
		return output;
	}
	
	// resolve ID
	def String resolveProxyURI(URI proxyUri){
		var modelRoot = DOCUMENT.childNodes
		
		for(el : MODEL.packagedElements){
			if(el instanceof ClassImpl){
				var attr = (el as ClassImpl)
				println(attr);
			}
		}
		println(proxyUri);
		return "";
	}
}