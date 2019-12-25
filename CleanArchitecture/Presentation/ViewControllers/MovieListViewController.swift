//
//  MovieListViewController.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 10/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class MovieListViewController: BaseViewController, StoryboardView, UICollectionViewDelegate {
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    typealias Reactor = MovieListViewReactor
    @IBOutlet weak var labelTotalResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bind(reactor: MovieListViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
}

private extension MovieListViewController {

    func bindAction(_ reactor: MovieListViewReactor) {
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(0.5, scheduler: MainScheduler.instance)
            .map {
                $0.isEmpty ? Reactor.Action.emptyInput : Reactor.Action.updateQuery(title: $0)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    func bindState(_ reactor: MovieListViewReactor) {
        
        reactor.state.map { $0.error }
            .ignoreNil()
            .subscribe(onNext: { [weak self] error in
                self?.showErrorToast(error)
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
        .distinctUntilChanged()
        .subscribe(onNext: { [weak self] isLoading in
            isLoading ? self?.activityIndicatorView.startAnimating() : self?.activityIndicatorView.stopAnimating()
        })
        .disposed(by: disposeBag)
        
        reactor.state.map { $0.movies }
            .bind(to: collectionViewMovies.rx.items(cellIdentifier: "MovieCell", cellType: MovieCell.self)) { (_, movie, cell) in
                cell.reactor = MovieCellReactor(movie: movie)
        }.disposed(by: disposeBag)
        
        collectionViewMovies.rx.contentOffset
            .filter { [weak self] offset in
                guard let self = self else { return false }
                guard self.collectionViewMovies.frame.height > 0 else { return false }
                return offset.y + self.collectionViewMovies.frame.height >= self.collectionViewMovies.contentSize.height - 100
        }
        .map { _ in Reactor.Action.loadMovies }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        collectionViewMovies.rx.modelSelected(Movie.self)
        .subscribe(onNext: { movie in
            reactor.showMovieDetail(movie)
        }).disposed(by: disposeBag)

        collectionViewMovies.rx.setDelegate(self)
        .disposed(by: disposeBag)
    
        reactor.state.map { $0.totalCount }
            .map { "검색 결과: \(String($0))" }
            .bind(to: labelTotalResult.rx.text)
            .disposed(by: disposeBag)
    }
    
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
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
