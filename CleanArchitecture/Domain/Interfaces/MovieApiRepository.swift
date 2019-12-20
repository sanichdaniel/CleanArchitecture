//
//  MovieRepository.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 15/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MovieApiRepository {
    func searchMovies(title: String, page: Int) -> Single<Resource<MovieResponse>>
}
