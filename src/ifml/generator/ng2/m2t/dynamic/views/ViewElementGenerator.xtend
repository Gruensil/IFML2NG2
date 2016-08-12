package ifml.generator.ng2.m2t.dynamic.views

import java.util.List
import IFML.Extensions.impl.ListImpl
import IFML.Core.ViewElement
import IFML.Extensions.impl.FormImpl

public class ViewElementGenerator {
	
	protected def String generateCode(List<ViewElement> viewElementList){
		var output = ""
		
		for (viewElement : viewElementList){
			switch viewElement {
				ListImpl: output += new ListGenerator().generateTemplate(viewElement)
				FormImpl: output += new FormGenerator().generateTemplate(viewElement)
				default: output += ""
			}
		}
		return output
	}
}
