package ifml.generator.ng2.core

import IFML.Core.CorePackage
import IFML.Core.IFMLModel
import IFML.DataTypes.DataTypesPackage
import IFML.Extensions.ExtensionsPackage
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl
import javax.xml.parsers.DocumentBuilderFactory
import java.io.File
import org.w3c.dom.Document

class ModelLoader {

	// File Extensions
	public static final String IFML_MODEL_FILE_EXTENSION = "core"
	
	// Meta-models' URI
	public static final String IFML_CORE_EPACKAGE_URI = "'http://www.omg.org/spec/20130218/core'" 
	public static final String IFML_EXTENSIONS_EPACKAGE_URI = "'http://www.omg.org/spec/20130218/ext'" 
	public static final String IFML_DATATYPE_EPACKAGE_URI = "'http://www.omg.org/spec/20130218/data'"
	
	def IFMLModel loadIFMLModel(String pathToIFMLFile) {

		// Register the IFML Packages 
		EPackage.Registry::INSTANCE.put(IFML_CORE_EPACKAGE_URI, CorePackage::eINSTANCE)
		EPackage.Registry::INSTANCE.put(IFML_EXTENSIONS_EPACKAGE_URI, ExtensionsPackage::eINSTANCE)
		EPackage.Registry::INSTANCE.put(IFML_DATATYPE_EPACKAGE_URI, DataTypesPackage::eINSTANCE)

		// Register the model factories 
		Resource.Factory.Registry::INSTANCE.extensionToFactoryMap.put(IFML_MODEL_FILE_EXTENSION,
			new XMIResourceFactoryImpl)

		// Instantiate the resource set				
		val resourceSet = new ResourceSetImpl

		// Extract & parse the IFML model
		val ifmlResource = resourceSet.getResource(URI::createURI(pathToIFMLFile), true)
		val ifmlModel = ifmlResource.contents.filter[e|e instanceof IFMLModel]?.get(0) as IFMLModel

		return ifmlModel;

	}
	
	def Document loadAdaptModel(String pathToAdaptFile) {
	    // parse an XML document into a DOM tree
	    var parser = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	    var document = parser.parse(new File(pathToAdaptFile));
	    
	    return document;
	}
}
