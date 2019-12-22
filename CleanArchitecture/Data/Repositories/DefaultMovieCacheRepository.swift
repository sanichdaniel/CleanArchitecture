//
//  DefaultMovieCacheRepository.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 16/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Disk

final class DefaultMovieCacheRepository {
    
    init() {
    }

}

extension DefaultMovieCacheRepository: MovieCacheRepository {
    func setFavorite(movie: Movie) {}
    func getFavorites() -> [Movie] {
        return []
    }
}
