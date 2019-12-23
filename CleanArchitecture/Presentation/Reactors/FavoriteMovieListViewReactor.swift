//
//  FavoriteMovieListViewReactor.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 15/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//


import ReactorKit
import RxSwift
import RxFlow
import RxCocoa

final class FavoriteMovieListViewReactor: Reactor, Stepper {
    let steps = PublishRelay<Step>()
    let movieCacheRepository: MovieCacheRepository
    
    init(movieCacheRepository: MovieCacheRepository) {
        self.movieCacheRepository = movieCacheRepository
    }

    enum Action {
        case fetchFavoriteMovies
    }
    
    enum Mutation {
        case setFavoriteMovies([Movie])
        case setTotal(Int)
    }
    
    struct State {
        var isLoading = false
        var favoriteMovies: [Movie] = []
        var totalCount: Int = 0
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchFavoriteMovies:
            let favoriteMovies: [Movie] = movieCacheRepository.getFavorites()
            return Observable.concat([.just(.setFavoriteMovies(favoriteMovies)), .just(.setTotal(favoriteMovies.count))])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setFavoriteMovies(movies):
            print("###", movies)
            newState.favoriteMovies = movies
        case let .setTotal(count):
            newState.totalCount = count
        }
        return newState
    }
    
    func showMovieDetail(_ movie: Movie) {
        self.steps.accept(MovieStep.showMovieDetial(movie))
    }
}
