package ifml.generator.ng2.m2t.general

abstract class AbstractViewElementGenerator<T> extends AbstractHtmlGenerator<T>{

	public override String generateCode(T it){
		// Give subclasses the change to prepare for the generation effort
		prepareGeneration
				
	    generateTemplate
	}
	
	protected abstract override void prepareGeneration(T it);

	protected abstract override String generateTemplate(T it);

}
