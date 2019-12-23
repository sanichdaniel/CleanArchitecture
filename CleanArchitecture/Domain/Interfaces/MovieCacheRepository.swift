//
//  MovieCacheRepository.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 16/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import Foundation

protocol MovieCacheRepository {
    func checkIsFavorite(movie: Movie) -> Bool
    func setFavorite(movie: Movie)
    func unSetFavorite(movie: Movie)
    func getFavorites() -> [Movie]
}
