package ifml.generator.ng2.core

import IFML.Core.IFMLModel
import IFML.Core.InteractionFlowElement
import com.google.common.base.CharMatcher
import IFML.Core.ViewContainer
import IFML.Core.ViewComponent
import IFML.Core.IFMLAction
import IFML.Core.ViewComponentPart
import IFML.Core.ViewElementEvent
import IFML.Core.IFMLParameter
import java.util.ArrayList
import IFML.Core.NamedElement
import IFML.Extensions.IFMLWindow
import IFML.Extensions.List
import IFML.Extensions.Form
import IFML.Extensions.Details
import IFML.Core.DataBinding
import IFML.Core.VisualizationAttribute
import IFML.Extensions.Field
import IFML.Extensions.OnSelectEvent
import java.io.InputStream
import javax.xml.validation.SchemaFactory
import javax.xml.XMLConstants
import javax.xml.validation.Schema
import javax.xml.transform.stream.StreamSource
import javax.xml.parsers.DocumentBuilder
import javax.xml.parsers.DocumentBuilderFactory
import java.io.File
import javax.xml.transform.dom.DOMSource
import org.xml.sax.SAXException
import org.w3c.dom.Document

class ModelValidator {
	
	Iterable<InteractionFlowElement> interactionFlowElements
	Iterable<IFMLAction> actions
	Iterable<ViewContainer> viewContainers
	Iterable<ViewComponent> viewComponents
	Iterable<IFMLParameter> parameters
	var viewComponentParts =  new ArrayList<ViewComponentPart> 
	var viewElementEvents = new ArrayList<ViewElementEvent>
	var namedElements = new ArrayList<NamedElement>
	
	def Boolean validate(IFMLModel model) {
	
		// Extract model elements
		interactionFlowElements = model.interactionFlowModel.interactionFlowModelElements.filter(typeof(InteractionFlowElement));	
		parameters = interactionFlowElements.map[e | e.parameters].flatten
		actions = interactionFlowElements.filter(typeof(IFMLAction))
		viewContainers = interactionFlowElements.filter(typeof(ViewContainer))	
		viewComponents = viewContainers.map[e | e.viewElements.filter(typeof(ViewComponent))].flatten;
		viewComponentParts.addAll(viewComponents.map[e | e.viewComponentParts].flatten)
		viewComponentParts.addAll(viewComponentParts.map[e | e.subViewComponentParts].flatten)
		viewElementEvents.addAll(viewContainers.map[e | e.viewElementEvents].flatten)
		viewElementEvents.addAll(viewContainers.map[e | e.viewElements.map[i | i.viewElementEvents].flatten].flatten);
		
		// Validate Model Elements
		return validateCamelCaseNames 
		&& validateUniqueDefaultContainer
		&& validateUniqueOutInteractionFlowForActions
		&& validateUniqueOutInteractionFlowForEvents
		&& validateViewComponentPartsType
		&& validateViewComponentsType
		&& validateViewContainersType
		&& validateDataBindingsWithMatchingParameter
		&& validateUniqueParameterBindingForOnSelectEvents;
		
	}
	
	// Named Elements should have a camelCase name
	private def Boolean validateCamelCaseNames(){
		
		namedElements.addAll(parameters)
		namedElements.addAll(actions)
		namedElements.addAll(viewContainers)
		namedElements.addAll(viewComponents)
		namedElements.addAll(viewComponentParts)
		namedElements.addAll(viewElementEvents)
		
		if(!namedElements.filter[ e | 
			e.name.isNullOrEmpty 
			|| CharMatcher.WHITESPACE.matchesAnyOf(e.name) 
			|| Character.isUpperCase(e.name.charAt(0))
		].isNullOrEmpty){
			
			println("[ERROR] All the 'Named Elements' in the IFML diagram should have a camelCase name")
			return false;
		}
		
		return true;
	}
	
	// There should be one and only one default window
	private def Boolean validateUniqueDefaultContainer(){
		
		if(viewContainers.filter[e | e.isIsDefault].length != 1) {
			
			println("[ERROR] The model should have exactly ONE default ViewContainer")
			return false;
		}	
		
		return true;
	}
	
	// Actions can have at most ONE outInteractionFlow
	private def Boolean validateUniqueOutInteractionFlowForActions(){
		
		if(!actions.forall[ a | a.outInteractionFlows.length <= 1]){
			
			println("[ERROR] The current version of the M2T tool can handle Actions with ONE outInteractionFlow only")
			return false;
		}
		
		return true;
	}
	
	// Events can have at most ONE outInteractionFlow
	private def Boolean validateUniqueOutInteractionFlowForEvents(){
		
		if(!viewElementEvents.forall[a | a.outInteractionFlows.length <= 1]){
			
			println("[ERROR] The current version of the M2T tool can handle Events with ONE outInteractionFlow only")
			return false;
		}
		
		return true;
	}
	
	// All the View Containers should be of Window type
	private def Boolean validateViewContainersType(){
	
		/*if(!viewContainers.forall[e | e instanceof IFMLWindow]){
			
			println("[ERROR] The current version of the M2T tool can only handle View Containers of type Window")
			return false;	
		}*/
		
		return true;
	}
	
	// All the View Components should be type: List, Form or Details
	private def Boolean validateViewComponentsType(){
		
		if(!viewComponents.forall[e | 
			e instanceof List 
			|| e instanceof Form 
			|| e instanceof Details
		]) {
			
			println("[ERROR] The current version of the M2T tool can only handle View Components of type List, Form or Details")
			return false;	
		}
		
		return true;
	}

	// All the View Component Parts should be of type: Field, DataBindings or Visualization Attribute
	private def Boolean validateViewComponentPartsType(){
		
		if(!viewComponentParts.forall[e |
			e instanceof DataBinding 
			|| e instanceof VisualizationAttribute 
			|| e instanceof Field
		]){
			
			println("[ERROR] The current version of the M2T tool can only handle View Component Parts  of type DataBinding, Field or VisualizationAttributes")
			return false;	
		}
			
		return true;
	}
	
	// Every View Component with a DataBinding should have a parameter with matching name
	private def Boolean validateDataBindingsWithMatchingParameter(){
		
		if(!viewComponents.forall[ v |
			
			val dataBinding = v.viewComponentParts.filter(typeof(DataBinding))?.head()
			
			if(dataBinding != null) {
				
				v.parameters.exists[ p | p.name == dataBinding.name ];
			}
			else {
				true
			}  
		]){
			
			println("[ERROR] The current version of the M2T tool expects every View Component with a DataBinding to have a parameter with matching name")
			return false;	
		}
		
		return true;
		
	}

	// The outInteractionFlows associated with OnSelectEvents should have exactly ONE parameter binding
	private def Boolean validateUniqueParameterBindingForOnSelectEvents(){
		
		val outInteractionFlows = viewElementEvents.filter(typeof(OnSelectEvent)).map[e | e.outInteractionFlows].flatten;
		
		//TODO
		/*if(!outInteractionFlows.forall[ e | e.parameterBindingGroup.parameterBindings.length == 1]) {
			
			println("[ERROR] The current version of the M2T tool expects the outInteractionFlows associated with OnSelectEvents to have exactly ONE parameter binding")
			return false;
		}*/
		
		return true;
	}
	
	public def Boolean validateAdaptFile(Document xml, String xsd){
	    // create a SchemaFactory capable of understanding WXS schemas
	    var factory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
	
	    // load a WXS schema, represented by a Schema instance
	    var schemaFile = new StreamSource(new File(xsd));
	    var schema = factory.newSchema(schemaFile);
	
	    // create a Validator instance, which can be used to validate an instance document
	    var validator = schema.newValidator();
	
	    // validate the DOM tree
	    try {
	    	validator.validate(new DOMSource(xml));
	    	return true;
	    } catch (SAXException e) {
	        // instance document is invalid!
	        println(e.message);
	        return false;
	    }	
	}
}

