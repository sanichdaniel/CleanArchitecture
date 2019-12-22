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
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        
        scrollView.rx.contentOffset.subscribe(onNext: { [weak self] offset in
            if offset.y < 0 {
                reactor.dismiss()
            }
            }).disposed(by: disposeBag)
        
        if let posterImageString = reactor.currentState.movie.posterImage, let imageURL = URL(string: posterImageString) {
            imageViewPoster.kf.setImage(with: imageURL)
        }
        
        reactor.state.map { $0.movie.title }
            .bind(to: labelTitle.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.movie.year }
            .bind(to: labelYear.rx.text)
            .disposed(by: disposeBag)
    }

    func bindAction(_ reactor: Reactor) {
        btnClose.rx.tap
            .subscribe(onNext: {
                reactor.dismiss()
            }).disposed(by: disposeBag)
        
        btnFavorite.rx.tap
            .map { Reactor.Action.setFavorite}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    func bindState(_ reactor: Reactor) {
    }
    
}
