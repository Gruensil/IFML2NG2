package ifml.generator.ng2.m2t.dynamic.app.views

import IFML.Core.ViewElement
import IFML.Extensions.OnSubmitEvent
import IFML.Extensions.impl.OnSubmitEventImpl
import IFML.Core.impl.IFMLActionImpl

public class OnSubmitEventGenerator {
	
	protected def String generateCode(ViewElement el){
		var output = "";
		
		var onSubmitEvents = el.viewElementEvents.filter(typeof(OnSubmitEventImpl));
		
		for (event : onSubmitEvents) {
			// only one out interaction flow supported at the moment
			var outInteractionFlow = event.outInteractionFlows.get(0);
			if(outInteractionFlow.targetInteractionFlowElement instanceof IFMLActionImpl){
				output += '''
				
					«event.name»(){
						this.«outInteractionFlow.targetInteractionFlowElement.name»();
					}
				
					«outInteractionFlow.targetInteractionFlowElement.name»(){
						// PROTECTED REGION ID «outInteractionFlow.targetInteractionFlowElement.id».«outInteractionFlow.targetInteractionFlowElement.name» ENABLED START
						// PROTECTED REGION END
					}
				''';
			}
		}
		
		return output;
	}
}
