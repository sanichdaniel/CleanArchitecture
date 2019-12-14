//
//  MovieFlow.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 10/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import Foundation
import RxFlow

final class MovieFlow: Flow {
    
    init() {
    }
    
    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        let vc = UINavigationController()
        return vc
    }()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MovieStep else { return .none }
        switch step {
        case .showMovieListView:
            return showMovieListView()
        case .showMovieDetial:
            return showMovieDetail()
        }
    }
    
    private func showMovieListView() -> FlowContributors {
        let movieListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        rootViewController.pushViewController(movieListVC, animated: true)
        movieListVC.reactor = MovieListViewReactor(searchComicsUseCase: DefaultMovieUseCase(networkService: Network<WebAPI>()))
        return .one(flowContributor: .contribute(withNextPresentable: movieListVC, withNextStepper: movieListVC.reactor!))
    }
    
    private func showMovieDetail() -> FlowContributors {
        let movieDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        rootViewController.pushViewController(movieDetailVC, animated: true)
        movieDetailVC.reactor = MovieDetailViewReactor()
        return .one(flowContributor: .contribute(withNextPresentable: movieDetailVC, withNextStepper: movieDetailVC.reactor))
    }
}
