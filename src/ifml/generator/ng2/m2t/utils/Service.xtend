package ifml.generator.ng2.m2t.utils

class Service {

	private String name;
	private String location;
	
	new(String n, String l){
		name = n;
		location = l
	}
	
	def setName(String n){
		name = n;
	}
		
	def setLocation(String l){
		location = l;
	}
	
	def getName(){
		return name;
	}
	
	def getLocation(){
		return location;
	}
}
