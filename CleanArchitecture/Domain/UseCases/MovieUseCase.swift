//
//  ComicUseCase.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 10/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import RxSwift

protocol MovieUseCase {
    func searchMovies(title: String, page: Int) -> Single<Resource<MovieResponse>>
    
    func checkIsFavorite(movie: Movie) -> Bool
    func setFavorite(movie: Movie)
    func unSetFavorite(movie: Movie)
    func getFavorites() -> [Movie]
}

final class DefaultMovieUseCase: MovieUseCase {
    private let movieApiRepository: MovieApiRepository
    private let movieCacheRepository: MovieCacheRepository
    
    init(movieApiRepository: MovieApiRepository, movieCacheRepository: MovieCacheRepository) {
        self.movieApiRepository = movieApiRepository
        self.movieCacheRepository = movieCacheRepository
    }
    
    func searchMovies(title: String, page: Int) -> Single<Resource<MovieResponse>> {
        return movieApiRepository.searchMovies(title: title, page: page)
    }
    
    func setFavorite(movie: Movie) {
        movieCacheRepository.setFavorite(movie: movie)
    }
    
    func checkIsFavorite(movie: Movie) -> Bool {
        return movieCacheRepository.checkIsFavorite(movie: movie)
    }
    
    func unSetFavorite(movie: Movie) {
        movieCacheRepository.unSetFavorite(movie: movie)
    }
    
    func getFavorites() -> [Movie] {
        movieCacheRepository.getFavorites()
    }
    
}
