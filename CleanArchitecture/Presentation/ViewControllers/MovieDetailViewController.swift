//
//  MovieDetailViewController.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 14/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class MovieDetailViewController: BaseViewController, StoryboardView {
    var disposeBag = DisposeBag()
    
    typealias Reactor = MovieDetailViewReactor
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bind(reactor: Reactor) {
        bindView(reactor)
        bindAction(reactor)
        bindState(reactor)
    }
}

private extension MovieDetailViewController {
    
    func bindView(_ reactor: Reactor) {
    }

    func bindAction(_ reactor: Reactor) {
    }

    func bindState(_ reactor: Reactor) {
    }
    
}
