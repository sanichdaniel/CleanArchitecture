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
        case updateQuery(title: String)
        case emptyInput
        case loadMovies
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setError(String?)
        case setQuery(String)
        case setMovies([Movie], Int)
        case appendMovies([Movie], Int)
    }
    
    struct State {
        var isLoading = false
        var error: String?
        var query: String?
        var movies: [Movie] = []
        var totalCount = 0
        var nextPage: Int = 1
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateQuery(title):
            guard !title.isEmpty else {
                return .empty()
            }
            return Observable.concat([
                .just(.setQuery(title)),
                .just(.setLoading(true)),
                self.searchMovies(query: title, page: 1),
                .just(.setLoading(false))
            ])
        case .emptyInput:
            return .just(.setMovies([], 0))
        case .loadMovies:
            guard !currentState.isLoading, let query = currentState.query else { return .empty() }
            return Observable.concat([
                .just(.setLoading(true)),
                self.searchMovies(query: query, page: currentState.nextPage + 1),
                .just(.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setError(error):
            newState.error = error
        case let .setQuery(query):
            newState.query = query
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
    
    func searchMovies(query: String, page: Int) -> Observable<Mutation> {
        return movieUseCase.searchMovies(title: query, page: page)
            .asObservable()
            .flatMap { resource -> Observable<Mutation> in
                switch resource {
                case let .Success(data):
                    guard let movies = data.movies, let totalResults = data.totalResults, let totalCount = Int(totalResults) else {
                        return .empty()
                    }
                    if page == 1 {
                        return .just(.setMovies(movies, totalCount))
                    } else {
                        return .just(.appendMovies(movies, totalCount))
                    }
                case let .Failure(error):
                    return .just(.setError(error))
                }
        }
    }
}
