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
        var posterImageUrl: URL?
        var title: String?
    }

    let initialState: State

    init(movie: Movie) {
        var posterImageUrl: URL? = nil
        if let urlString = movie.posterImage, !urlString.isEmpty, let posterUrl = URL(string: urlString) {
            posterImageUrl = posterUrl
        }
        self.initialState = State(posterImageUrl: posterImageUrl, title: movie.title)
    }
}
