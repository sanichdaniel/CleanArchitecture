//
//  MovieDetailViewReactor.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 14/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import ReactorKit
import RxSwift
import RxFlow
import RxCocoa

final class MovieDetailViewReactor: Reactor, Stepper {
    let steps = PublishRelay<Step>()
    let movieCacheRepository: MovieCacheRepository
    
    let initialState: State
    
    init(movieCacheRepository: MovieCacheRepository, movie: Movie) {
        self.movieCacheRepository = movieCacheRepository
        self.initialState = State(movie: movie)
    }

    enum Action {
        case setFavorite
    }
    
    enum Mutation {
    }
    
    struct State {
        var movie: Movie
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setFavorite:
            movieCacheRepository.setFavorite(movie: currentState.movie)
            return .empty()
        default:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        }
        return newState
    }
    
    func dismiss() {
        self.steps.accept(MovieStep.dismiss)
    }
}
