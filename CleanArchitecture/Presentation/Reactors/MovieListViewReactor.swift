//
//  MovieListViewReactor.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 10/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import ReactorKit
import RxSwift
import RxFlow
import RxCocoa

final class MovieListViewReactor: Reactor, Stepper {
    let steps = PublishRelay<Step>()
    let movieUseCase: MovieUseCase
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
    }

    enum Action {
        case searchMovies(title: String, fetchNextPage: Bool)
        case emptyInput
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setError(String?)
        case setMovies([Movie], Int)
        case appendMovies([Movie], Int)
    }
    
    struct State {
        var isLoading = false
        var error: String?
        var movies: [Movie] = []
        var totalCount = 0
        var nextPage: Int = 1
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .searchMovies(title, fetchNextPage):
            guard !title.isEmpty else {
                return .empty()
            }
            let searchMovies: Observable<Mutation> = movieUseCase.searchMovies(title: title, page: fetchNextPage ? currentState.nextPage + 1 : 1)
                .asObservable()
                .flatMap { resource -> Observable<Mutation> in
                    switch resource {
                    case let .Success(data):
                        guard let movies = data.movies, let totalResults = data.totalResults, let totalCount = Int(totalResults) else {
                            return .empty()
                        }
                        if fetchNextPage {
                            return .just(.appendMovies(movies, totalCount))
                        } else {
                            return .just(.setMovies(movies, totalCount))
                        }
                    case let .Failure(error):
                        return .just(.setError(error))
                    }
            }
            return Observable.concat([
                .just(.setLoading(true)),
                searchMovies,
                .just(.setLoading(false))
            ])
        case .emptyInput:
            return .just(.setMovies([], 0))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setError(error):
            newState.error = error
        case let .setMovies(movies, totalCount):
            newState.movies = movies
            newState.totalCount = totalCount
            newState.nextPage = 1
        case let .appendMovies(movies, totalCount):
            newState.movies = currentState.movies + movies
            newState.totalCount = totalCount
            newState.nextPage = currentState.nextPage + 1
        }
        return newState
    }
    
    func showMovieDetail(_ movie: Movie) {
        self.steps.accept(MovieStep.showMovieDetial(movie))
    }
}
