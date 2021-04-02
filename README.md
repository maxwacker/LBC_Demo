# LBC_Demo 
 Master/Detail Clean Architecture Demo App
 
## Architectural principles

### General principles (Clean Architecture)
1. **Dependency Injection** : Every dependencies are defined through abstractions (protocols), so components are lightly coupled and easy to fake while unit testing
2. **Dependency Inversion** : Service abstraction are defined on caller side. The concrete implementation component imports declaration. The abstraction -> concrete resolution is made by _Abstract Factory_ pattern
3. **Interface Segregation** : Common reusable services (like dataStore) are accesssed through distincts abstractions depending on what part of the service is really in use
4. **Single Responsibility** : Each Use Case of the app (each screen : master & detail) is decomposed in a chain of decoupled components with very restricted responsibility, inspired by _VIPER_ Approach (see below)

At Xcode project structure level, this result in many targets which can be built in isolation, greatly accelerating builds and unit tests execution (allowing quick and confortable _Test Driven Development_). Further more, The folder structure of each target is designed to easily externalizing the component in its own Swift Package (SPM).

### VIPER responsibility chaining
VIPER stands for View / Interactor / Presenter / Entity / Router.
Each Scene (ie: each use case screen) of the application is designed as collaboration network of these component.

* **View**
	These are user interface components. They don't have  any application logic or business logic responsability. Their only responsibilities are :
	* Receiving data to display from Presenter
	* Emiting user interaction to Interactor
  

* **Interactor**
	This is the Use Case (application logic) implementation place. Interactor receives user interaction request from View, retreives the  business data needed to build the user feedback response, gives the data to the presenter.

	
* **Presenter**
	Play the role of data aggregator between Interactor and View.
	Interactor gives business (entity related) data objects as input to the presenter. Presenter process and emits simple display  data to (mostly String and Enums) View. So that View are not coupled to to business or application logic, and so reusable in many use cases.


* **Entities**
	These are Business model objets, holding the business specific logic rules (different from application logic)


* **Router**
	Sometimes user interaction leads to changes the whole display scene (master->detail transition for ex). When such user request arrives from View to Interactor, the need to change the current Scene is detected by the Interactor but the responsibility of it is on the Router. Decoupling the user action from the navigation effect results in an application more flexible to navigation design changes and greatly simplify deeplinking.
	

Depedency Inversion Principle

  ![VIPER](Documentation/VIPER_Components.png)

## Files Folders Structure

So, as shown in the previous diagram, every application scene is implemented as a VIPER chain of components. 
During the development of a new Scene, it's comfortable to organize the scene files in a dedicated target, so it builds very quickly (without needing to build the whole app).
And since every components interfaces are defined by (protocol) abstractions, faking dependencies is also easy. 
These 2 benefits allow to have a Test Driven Development (TDD) approach.  

When a Scene is developed this way and finished (generally well tested, thanks to TDD), it could be isolated in its own Swift Package, and by this way make the Scene available as dynamic linkable binary.

So the 2-letters folder naming convention is a good preparation of such SPM packaging. When exported into an SPM package, each folders becomes a target inside the package. Please remark that in the diagram there is cycle in the arrow networks, neither in the reference directed graph (blue arrows), not in the import direct graph (black arrows). No reference cycle means no memory leak (no retain cycle). No import cycle means the Scene component could be divided in even more sub-components : 1 component for each 2-letters folders.




