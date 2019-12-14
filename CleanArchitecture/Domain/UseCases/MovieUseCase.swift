//
//  ComicUseCase.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 10/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import RxSwift

protocol MovieUseCase {
    func fetchComics(title: String) -> Single<Resource<MovieResponse>>
}

final class DefaultMovieUseCase: MovieUseCase {
    let networkService: CANetwork
    
    init(networkService: CANetwork) {
        self.networkService = networkService
    }
    
    func fetchComics(title: String) -> Single<Resource<MovieResponse>> {
        return networkService.request(.searchMovies(title: title), responseType: MovieResponse.self)
    }
    
}
