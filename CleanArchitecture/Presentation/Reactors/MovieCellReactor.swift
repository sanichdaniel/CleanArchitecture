//
//  MovieCellReactor.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 14/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import ReactorKit

final class MovieCellReactor: Reactor {
    typealias Action = NoAction

    struct State {
        var posterImage: String?
    }

    let initialState: State

    init(movie: Movie) {
        self.initialState = State(posterImage: movie.posterImage)
    }
}
