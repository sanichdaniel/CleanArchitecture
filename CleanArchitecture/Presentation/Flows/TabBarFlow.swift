//
//  TabbarFlow.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 15/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//
import Foundation
import RxFlow

final class TabBarFlow: Flow {
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UITabBarController = {
        let vc = UITabBarController()
        vc.tabBar.barStyle = .black
        return vc
    }()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MovieStep else { return .none }
        switch step {
        case .showMovieListView:
            return showMovieListView()
        default:
            return .none
        }
    }
    
    private func showMovieListView() -> FlowContributors {
        let flow1 = MovieFlow(container: container)
        let flow2 = FavoriteFlow(container: container)
        Flows.whenReady(flow1: flow1, flow2: flow2) { [unowned self] (root1: UINavigationController, root2: UINavigationController) in
            root1.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
            root2.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
            self.rootViewController.setViewControllers([root1, root2], animated: false)
        }
        return .multiple(flowContributors: [.contribute(withNextPresentable: flow1,
                                                        withNextStepper: OneStepper(withSingleStep: MovieStep.showMovieListView)), .contribute(withNextPresentable: flow2, withNextStepper: OneStepper(withSingleStep: MovieStep.showFavoriteListView))])
    }
}
