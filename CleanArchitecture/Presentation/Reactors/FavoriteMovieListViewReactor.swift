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
    
    init() {
        
    }

    enum Action {
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var isLoading = false
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        }
        return newState
    }
    
    func showMovieDetail(_ movie: Movie) {
        self.steps.accept(MovieStep.showMovieDetial(movie))
    }
}
