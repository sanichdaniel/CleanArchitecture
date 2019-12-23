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
        return networkService.request(.searchMovies(title: title, page: page), responseType: MovieResponse.self)
    }
}
