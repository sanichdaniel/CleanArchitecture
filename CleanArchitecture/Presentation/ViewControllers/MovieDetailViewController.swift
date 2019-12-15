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
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var disposeBag = DisposeBag()
    
    typealias Reactor = MovieDetailViewReactor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        labelTitle.textColor = .white
        labelYear.textColor = .white
    }

    func bind(reactor: Reactor) {
        bindView(reactor)
        bindAction(reactor)
        bindState(reactor)
    }
}

private extension MovieDetailViewController {
    
    func bindView(_ reactor: Reactor) {
        
        if let posterImageString = reactor.currentState.movie.posterImage, let imageURL = URL(string: posterImageString) {
            imageViewPoster.kf.setImage(with: imageURL)
        }

        labelTitle.text = reactor.currentState.movie.title
        
        labelYear.text = reactor.currentState.movie.year
    }

    func bindAction(_ reactor: Reactor) {
        btnClose.rx.tap
            .subscribe(onNext: {
                reactor.dismiss()
            }).disposed(by: disposeBag)
    }

    func bindState(_ reactor: Reactor) {
    }
    
}
