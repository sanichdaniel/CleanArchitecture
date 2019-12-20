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
        default:
            return .none
        }
    }
    
    private func showFavoriteListView() -> FlowContributors {
        let vc = UIViewController()
        rootViewController.pushViewController(vc, animated: true)
        return .none
    }
}
