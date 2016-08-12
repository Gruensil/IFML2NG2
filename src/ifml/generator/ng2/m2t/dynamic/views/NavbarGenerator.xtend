package ifml.generator.ng2.m2t.dynamic.views;

import ifml.generator.ng2.m2t.general.AbstractViewElementGenerator
import IFML.Extensions.IFMLWindow
import IFML.Extensions.impl.IFMLWindowImpl

public class NavbarGenerator extends AbstractViewElementGenerator<IFMLWindow>{
	
	override protected generateTemplate(IFMLWindow it) {
		var output = ""
		
		output += '''
			<div class="sidebar-navbar">
				<div class="sidebar-wrapper">
					<ul class="sidebar-nav">		
		'''
		
	    for (viewElementEvent : it.viewElementEvents){
			for( outInteractionFlow : viewElementEvent.outInteractionFlows ){
				if(outInteractionFlow.targetInteractionFlowElement instanceof IFMLWindowImpl){
					output += '''
							<li class="divLine">
								<a *isDesktop href="\«outInteractionFlow.targetInteractionFlowElement.name.toFirstLower»">«outInteractionFlow.targetInteractionFlowElement.name»</a>
							</li>
					'''	
				}
			}
		}
		
		output += '''
					</ul>
				</div>
			</div>
		'''		
		
		return output
	}
	
	override protected prepareGeneration(IFMLWindow it) {
	}
	
}