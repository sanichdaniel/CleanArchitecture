//
//  FavoriteFlow.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 15/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import Foundation
import RxFlow

final class FavoriteFlow: Flow {
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
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
        case .showFavoriteListView:
            return showFavoriteListView()
        case let .showMovieDetial(movie):
            return showMovieDetailView(movie: movie)
        case .dismiss:
            rootViewController.dismiss(animated: true, completion: nil)
            return .none
        default:
            return .none
        }
    }
    
    private func showFavoriteListView() -> FlowContributors {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoriteMovieListViewController") as! FavoriteMovieListViewController
        vc.reactor = container.makeFavoriteMovieListViewReactor()
        vc.modalPresentationStyle = .overFullScreen
        rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    
    private func showMovieDetailView(movie: Movie) -> FlowContributors {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        vc.reactor = container.makeMovieDetailViewReactor(movie: movie)
        vc.modalPresentationStyle = .overFullScreen
        rootViewController.present(vc, animated: true, completion: nil)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
}
