//
//  DIContainer.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 10/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import UIKit

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
    
    func makeMovieCacheRepository() -> MovieCacheRepository {
        return DefaultMovieCacheRepository()
    }
    
    // MARK: Reactors
    func makeMovieListViewReactor() -> MovieListViewReactor {
        return MovieListViewReactor(movieUseCase: makeMovieUseCase())
    }
    
    func makeMovieCellReactor(movie: Movie) -> MovieCellReactor {
        return MovieCellReactor(movie: movie)
    }
    
    func makeFavoriteMovieListViewReactor() -> FavoriteMovieListViewReactor {
        return FavoriteMovieListViewReactor()
    }
    
    func makeMovieDetailViewReactor(movie: Movie) -> MovieDetailViewReactor {
        return MovieDetailViewReactor(movieCacheRepository: makeMovieCacheRepository(), movie: movie)
    }
    
}
