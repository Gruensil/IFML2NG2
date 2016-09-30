package ifml.generator.ng2.m2t.dynamic.app.views

import IFML.Core.ViewElement
import IFML.Core.impl.IFMLActionImpl
import IFML.Extensions.impl.OnSelectEventImpl
import IFML.Core.impl.ViewContainerImpl
import IFML.Extensions.impl.ListImpl

public class OnSelectEventGenerator {
	
	protected def String generateCode(ViewElement el){
		var output = "";
		
		var onSelectEvents = el.viewElementEvents.filter(typeof(OnSelectEventImpl));
		
		for (event : onSelectEvents) {
			// only one out interaction flow supported at the moment
			var outInteractionFlow = event.outInteractionFlows.get(0);
			if(outInteractionFlow.targetInteractionFlowElement instanceof IFMLActionImpl){
				output += '''
				
					«event.name»(){
						this.«outInteractionFlow.targetInteractionFlowElement.name»Action();
					}
				
					«outInteractionFlow.targetInteractionFlowElement.name»Action(){
						// PROTECTED REGION ID «outInteractionFlow.targetInteractionFlowElement.id».«outInteractionFlow.targetInteractionFlowElement.name» ENABLED START
						// PROTECTED REGION END
					}
				''';
			}else if(outInteractionFlow.targetInteractionFlowElement instanceof ViewContainerImpl){
				if(outInteractionFlow.parameterBindingGroup != null){
					output += '''
						«event.name»(){
							this._router.navigate(['/«outInteractionFlow.targetInteractionFlowElement.name.toFirstLower»', {«outInteractionFlow.parameterBindingGroup.parameterBindings.get(0).targetParameter.name»: JSON.stringify(this.selected«outInteractionFlow.parameterBindingGroup.parameterBindings.get(0).sourceParameter.name.toFirstUpper»)}]);
						}
					''';
				}else{
					output += '''
						«event.name»(){
							this._router.navigate(['/«outInteractionFlow.targetInteractionFlowElement.name.toFirstLower»']);
						}
					''';
				}
			}
			else{
				output += '''
					«event.name»(){
						// PROTECTED REGION ID «event.id».«event.name» ENABLED START
						// PROTECTED REGION END
					}
				''';
			}
		}
		
		return output;
	}
}
