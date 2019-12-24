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
    let movieUseCase: MovieUseCase
    
    let initialState: State
    
    init(movieUseCase: MovieUseCase, movie: Movie) {
        self.movieUseCase = movieUseCase
        self.initialState = State(movie: movie, isFavorite: movieUseCase.checkIsFavorite(movie: movie))
    }

    enum Action {
        case setFavorite
    }
    
    enum Mutation {
        case setFavorite
    }
    
    struct State {
        var movie: Movie
        var isFavorite: Bool
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setFavorite:
            if currentState.isFavorite {
                movieUseCase.unSetFavorite(movie: currentState.movie)
            } else {
                movieUseCase.setFavorite(movie: currentState.movie)
            }
            return .just(.setFavorite)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setFavorite:
            newState.isFavorite = movieUseCase.checkIsFavorite(movie: currentState.movie)
        }
        return newState
    }
    
    func dismiss() {
        self.steps.accept(MovieStep.dismiss)
    }
}
