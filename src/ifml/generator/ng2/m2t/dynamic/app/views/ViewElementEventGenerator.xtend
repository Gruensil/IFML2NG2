package ifml.generator.ng2.m2t.dynamic.app.views

import java.util.List
import IFML.Extensions.impl.ListImpl
import IFML.Core.ViewElement
import IFML.Extensions.impl.FormImpl

public class ViewElementEventGenerator {
	
	protected def String generateCode(List<ViewElement> viewElementList){
		var output = ""
		
		for (viewElement : viewElementList){
			switch viewElement {
				// for each event
				
				// OnSelect
				ListImpl: output += new OnSelectEventGenerator().generateCode(viewElement)
				
				// OnSubmitEvent
				FormImpl: output += new OnSubmitEventGenerator().generateCode(viewElement)
				
				// ViewElementEvent
				//DetailsImpl: output += new DetailsGenerator().generateTemplate(viewElement)
				default: output += ""
			}
		}
		return output
	}
}
