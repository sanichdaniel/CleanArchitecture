//
//  MovieStep.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 10/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import Foundation
import RxFlow

enum MovieStep: Step {
    case showMovieListView
    case showMovieDetial(Movie)
    case dismiss
}
