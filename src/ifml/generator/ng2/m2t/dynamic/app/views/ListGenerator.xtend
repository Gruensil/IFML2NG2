package ifml.generator.ng2.m2t.dynamic.app.views;

import IFML.Extensions.impl.ListImpl;
import ifml.generator.ng2.m2t.general.AbstractViewElementGenerator
import IFML.Extensions.impl.OnSelectEventImpl

public class ListGenerator extends AbstractViewElementGenerator<ListImpl>{
	
	override protected generateTemplate(ListImpl listElement) {
		var output = ""

		var dataBinding = listElement.viewComponentParts.get(0)
		var visualizationAttributes = dataBinding.subViewComponentParts.toList()
		 
		output += '''
			<table id="«listElement.id»" name="«listElement.name»" class="table table-striped table-hover table-condensed">
				<thead>
		'''
		
		for(attribute : visualizationAttributes){
			output += '''
				<th>
					{{_resource.getLangString('«attribute.name»')}}
				</th>
			'''
		}
		
		output += '''
				</thead>
				<tbody>
		'''
		
		if(!listElement.viewElementEvents.isEmpty()) {
			var onSelectEvent = listElement.viewElementEvents.filter(OnSelectEventImpl).get(0)
			output += '''
				<tr *ngFor="let el of «dataBinding.name»" (click)="«onSelectEvent.name»()">
			'''
		}else{
			output += '''
				<tr *ngFor="let el of «dataBinding.name»">
			'''
		}
		
		for(attribute : visualizationAttributes){
			output += '''			
				<td>
					{{el.«attribute.name»}}
				</td>
			'''
		}			
		
		output += '''
					</tr>
				</tbody>
			</table>
		'''
		
		return output
	}
	
	override protected prepareGeneration(ListImpl it) {
	}
	
}