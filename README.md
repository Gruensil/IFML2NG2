# IFML2NG2

IFML2NG2 is a model-2-text generator for generating Angular 2 web applications from IFML models. The basis of the transformation is an IFML model of the application to be generated. Also a service vor adapting the application at runtime is generated. The service uses Nools to evaluate Rules with associated actions which can be used to change the UI.
Application Logic is not part of the generation result.
This project is work in progress.

## Project Structure
Package **core** contains classes for rudimentary tasks like loading of files and models, validation and controlling the generator. 
Package **m2t** contains subpackages with the transformation classes. 
**boilerplate** classes are files which are static and are the same for similar applications. 
**dynamic** classes are generated dynamically by the generator according to the IFML model.

The project folder **static** contains static files that are only copied to the destination. These include mock data and authentication as well as data services for the example application.
The project folder **data** contains the models and other necessary files to start the generation for the example application.

# Setup

## Requirements
* Cloned GIT Repository
* NPM - Package Manager for JavaScript (to run ng2 application)
* Eclipse with following plugins (to build ng2 application)
	* Xtend SDK
	* IFML Editor

## Run Generator
The following runtime arguments need to be provided:

1. Path to IFML model in ecore format
2. Path to domain model in uml format
3. Path to AdaptUI file in xml format
4. Path to AdaptUI XML schema definition
5. Path to files which need to be copied to destination folder (e.g. static files)
6. Path to destination folder

If all these runtime arguments are provided and the generation process is successful, the message **M2T IFML2NG2 finished!** will be displayed in the console. If the destination folder is empty, some warnings may appear.

## Run Generated Application
1. Install NPM packages (console in dest. folder: >npm install)
2. Host Application (console in dest. folder: >npm start)
3. Application is opened in browser

The provided example application already has some included user data.
To login as library staff member use account user:admin pw:admin.
To login as student use account user:hstahl pw:hstahl.
