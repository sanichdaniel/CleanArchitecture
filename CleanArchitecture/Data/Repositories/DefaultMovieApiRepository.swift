//
//  DefaultMovieApiRepository.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 16/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class DefaultMovieApiRepository {
    
    let networkService: CANetwork
    
    init(networkService: CANetwork) {
        self.networkService = networkService
    }

}

extension DefaultMovieApiRepository: MovieApiRepository {
    func searchMovies(title: String, page: Int) -> Single<Resource<MovieResponse>> {
        let movies = [Movie(year: "2123", type: "$@$", title: "Titanic", imdbID: "123", poster: "#@#"), Movie(year: "121", type: "$@$", title: "GLoria", imdbID: "124", poster: "#@#"), Movie(year: "2332", type: "$@$", title: "Tell Me", imdbID: "125", poster: "#@#")]
        let movieResponse = MovieResponse(totalResults: "3", movies: movies, error: nil, response: "true")
        return Single.just(Resource.Success(movieResponse))
        return networkService.request(.searchMovies(title: title, page: page), responseType: MovieResponse.self)
    }
}
