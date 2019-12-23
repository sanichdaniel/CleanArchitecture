Clean Architecture
===
iOS Sample project of movies implemented with CleanArchitecture and MVVM.

Architecture
---

App Divided into Domain, Presentation, Data Layer

* Domain Layer: Entity, Use Case, Repository Interface

* Presentation: ViewController, View, Reactor

* Data Layer: implementation of repository

![Alt text](README_FILES/folder.png?raw=true "Folder")

![Alt text](README_FILES/CleanArchitecture.png?raw=true "Clean Artitecture") { width: 100px; }


* Unidirectional Flow

ViewController -> Reactor -> UseCase -> Repository 
                        <-              <-                 <-
                        
* Navigation done by *RxFlow*


DI with Factory Pattern
---
Factory is in charge of making instances
 
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
