package ifml.generator.ng2.m2t.dynamic.app.views;

import ifml.generator.ng2.m2t.general.AbstractViewElementGenerator
import IFML.Extensions.IFMLWindow
import IFML.Extensions.impl.IFMLWindowImpl
import IFML.Core.impl.ViewContainerImpl

public class NavbarGenerator extends AbstractViewElementGenerator<ViewContainerImpl>{
	
	override protected generateTemplate(ViewContainerImpl it) {
		var output = ""
		
		output += '''
			<div class="sidebar-navbar">
				<div class="sidebar-wrapper">
					<ul class="sidebar-nav">		
		'''
		
	    for (viewElementEvent : it.viewElementEvents){
			for( outInteractionFlow : viewElementEvent.outInteractionFlows ){
				if(outInteractionFlow.targetInteractionFlowElement instanceof ViewContainerImpl){
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
	
	override protected prepareGeneration(ViewContainerImpl it) {
	}
	
}