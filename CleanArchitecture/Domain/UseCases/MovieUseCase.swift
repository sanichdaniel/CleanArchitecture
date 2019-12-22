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
    
    func setFavorite(movie: Movie)
}

final class DefaultMovieUseCase: MovieUseCase {
    private let movieApiRepository: MovieApiRepository
    
    init(movieApiRepository: MovieApiRepository) {
        self.movieApiRepository = movieApiRepository
    }
    
    func searchMovies(title: String, page: Int) -> Single<Resource<MovieResponse>> {
        return movieApiRepository.searchMovies(title: title, page: page)
    }
    
    func setFavorite(movie: Movie) {
        return
    }
    
}
