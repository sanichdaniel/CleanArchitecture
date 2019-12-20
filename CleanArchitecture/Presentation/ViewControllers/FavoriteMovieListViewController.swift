//
//  FavoriteMovieListViewController.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 15/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class FavoriteMovieListViewController: BaseViewController, StoryboardView, UICollectionViewDelegate {
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    typealias Reactor = FavoriteMovieListViewReactor
    @IBOutlet weak var labelTotalResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bind(reactor: Reactor) {
        bindView(reactor)
        bindAction(reactor)
        bindState(reactor)
    }
}

private extension FavoriteMovieListViewController {
    
    func bindView(_ reactor: Reactor) {
        
    }

    func bindAction(_ reactor: Reactor) {
        
    }

    func bindState(_ reactor: Reactor) {
        
//        reactor.state.map { $0.movies }
//            .bind(to: collectionViewMovies.rx.items(cellIdentifier: "MovieCell", cellType: MovieCell.self)) { (_, movie, cell) in
//                cell.reactor = MovieCellReactor(movie: movie)
//        }.disposed(by: disposeBag)
//        
//        collectionViewMovies.rx.modelSelected(Movie.self)
//        .subscribe(onNext: { movie in
//            reactor.showMovieDetail(movie)
//        }).disposed(by: disposeBag)
//
//        collectionViewMovies.rx.setDelegate(self)
//        .disposed(by: disposeBag)
    }
    
}

extension FavoriteMovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = view.frame.width - (60)
        let widthPerItem = availableWidth / 3
        return CGSize(width: widthPerItem, height: widthPerItem * 1.4)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
