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
//        if let posterImageString = movie.posterImage, !posterImageString.isEmpty,
        
            self.initialState = State(posterImageUrl: nil, title: movie.title)
    }
    
//    if let url = reactor.currentState.posterImage, !url.isEmpty, let imageURL = URL(string: url) {
//        imageViewPoster.kf.setImage(with: imageURL)
//        labelMovieTitle.isHidden = true
//    } else {
//        labelMovieTitle.text = reactor.currentState.title
//        labelMovieTitle.isHidden = false
//    }
}
