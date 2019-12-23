Clean Architecture
===
iOS Sample project of movies implemented with CleanArchitecture and MVVM.

Inspired by studying clean architecture  
 (https://github.com/sanichdaniel/today-I-learned/blob/master/swift/cleanArchitecture.md)

Architecture
---

App Divided into Domain, Presentation, Data Layer

* Domain Layer: Entity, Use Case, Repository Interface. Repository contains web api and caching

* Presentation: ViewController, View, Reactor

* Data Layer: implementation of repository

**Dependency Rule**
Inner layer does not know about outer layer!

However Data Flow insists that Domain Layer get Data from Data Layer. So Domain layer could have dependency of Data Layer.
Here comes *Dependency Inversion*. Domain Layer and Data Layer both depend on interface of repository.

<img src="README_FILES/folder.png" width="300"> <img src="README_FILES/CleanArchitecture.png" width="400">


* Unidirectional Flow

ViewController -> Reactor -> UseCase -> Repository -> UseCase -> Reactor -> ViewController
                        
* Navigation done by *RxFlow*


DI with Factory Pattern
---
Use Factory pattern to encapsulate object creation 
* define factory methods

~~~swift
final class DIContainer {
    var networkService: CANetwork {
        return Network<WebAPI>()
    }

    // MARK: Use Cases
    func makeMovieUseCase() -> MovieUseCase {
        return DefaultMovieUseCase(movieApiRepository: makeMovieApiRepository())
    }

    // MARK: Repositories
    func makeMovieApiRepository() -> MovieApiRepository {
        return DefaultMovieApiRepository(networkService: networkService)
    }
    ...
}

~~~

* usage

~~~swift
movieDetailVC.reactor = container.makeMovieDetailViewReactor(movie: movie)
~~~

TODO
---
* add test codes to each domain, presentation, data layer
