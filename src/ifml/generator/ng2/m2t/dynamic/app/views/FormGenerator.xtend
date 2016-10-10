package ifml.generator.ng2.m2t.dynamic.app.views;

import ifml.generator.ng2.m2t.general.AbstractViewElementGenerator
import IFML.Extensions.impl.FormImpl
import IFML.Extensions.OnSubmitEvent
import ifml.generator.ng2.m2t.utils.ServiceCollection

public class FormGenerator extends AbstractViewElementGenerator<FormImpl>{
	
	override protected generateTemplate(FormImpl el) {
		var output = ""
		
		var fields = el.viewComponentParts
		var onSubmitEvent = el.viewElementEvents.filter(typeof(OnSubmitEvent)).get(0)
		
		output += '''
			<form id="«el.id»" name="«el.name»" class="form-horizontal">
		'''
		
		for(field : fields){
			output += '''
				<div class="form-group">
					<label for="«field.id»" class="col-sm-2 control-label">{{_«ServiceCollection.sharedInstance.resource.name.toFirstLower».getLangString('«field.name»')}}</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="«field.id»" [(ngModel)]="«field.name»">
					</div>
				</div>
			'''
		}
		
		output += '''
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button id="«onSubmitEvent.id»" name="«onSubmitEvent.name»" (click)="«onSubmitEvent.name»()" type="submit" class="btn btn-default">{{_«ServiceCollection.sharedInstance.resource.name.toFirstLower».getLangString('«onSubmitEvent.name»')}}</button>
					</div>
				</div>
		'''
		
		output += '''
			</form>
		'''
		
		return output
	}
	
	override protected prepareGeneration(FormImpl it) {
	}
	
}