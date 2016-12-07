package ifml.generator.ng2.m2t.utils

import java.util.ArrayList

class ServiceCollection {

	private static ServiceCollection INSTANCE
	private Service authentication
	private Service data
	private Service resource
	private Service displayProperties
	private Service profile
	private ArrayList<Service> services = new ArrayList<Service>()
	
	private ArrayList<Service> tempArray = new ArrayList<Service>()
	
	static def ServiceCollection sharedInstance(){
		if(INSTANCE == null) {
			INSTANCE = new ServiceCollection();
		}
		return INSTANCE;
	}
	
	def setAuthentication(String name, String location){
		authentication = new Service(name, location)
	}
	
	def setData(String name, String location){
		data = new Service(name, location)
	}
		
	def setDisplayProperties(String name, String location){
		displayProperties = new Service(name, location)
	}
	
	def setProfile(String name, String location){
		profile = new Service(name, location)
	}
	
	def setResource(String name, String location){
		resource = new Service(name, location)
	}
		
	def addService(String name, String location){
		services.add(new Service(name, location))
	}
	
	def getAuthentication(){
		return authentication
	}
	
	def getData(){
		return data
	}
		
	def getDisplayProperties(){
		return displayProperties
	}
	
	def getProfile(){
		return profile
	}
	
	def getResource(){
		return resource
	}
	
	def getServices(){
		tempArray.clear;
		for(service: services){
			tempArray.add(service)
		}
		if(authentication != null){
			tempArray.add(authentication)
		}
		if(data != null){
			tempArray.add(data)
		}
		if(displayProperties != null){
			tempArray.add(displayProperties)
		}
		if(profile != null){
			tempArray.add(profile)
		}
		if(resource != null){
			tempArray.add(resource)
		}
		return tempArray
	}
	
	def getProviders(){
		tempArray.clear;
		for(service: services){
			tempArray.add(service)
		}
		if(displayProperties != null){
			tempArray.add(displayProperties)
		}
		if(authentication != null){
			tempArray.add(authentication)
		}
		if(data != null){
			tempArray.add(data)
		}
		return tempArray		
	}
}
