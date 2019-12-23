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
    
    private var cachedMovies: [Movie] {
        get {
            return self.getFavorites()
        }
    }
    
    init() {
    }

}

extension DefaultMovieCacheRepository: MovieCacheRepository {
    
    func checkIsFavorite(movie: Movie) -> Bool {
        return cachedMovies.contains(where: { $0.imdbID == movie.imdbID })
    }
    
    func setFavorite(movie: Movie) {
        do {
            var movies = cachedMovies.filter { $0.imdbID == movie.imdbID }
            movies.insert(movie, at: 0)
            try Disk.append(movies, to: "movies", in: .caches)
        } catch {
            return
        }
    }
    
    func unSetFavorite(movie: Movie) {
        do {
            let movies = cachedMovies.filter { $0.imdbID != movie.imdbID}
            try Disk.save(movies, to: .caches, as: "movies")
        } catch {
            return
        }
    }
    
    func getFavorites() -> [Movie] {
        do {
            return try Disk.retrieve("movies", from: .caches, as: [Movie].self)
        } catch {
            return []
        }
    }
}
