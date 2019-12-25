//
//  AppDelegate.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 08/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireNetworkActivityLogger
import RxFlow

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let appDIContainer = DIContainer()
    var coordinator = FlowCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        #if DEBUG
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
        #endif
        
        let tabBarFlow = AppFlow(container: appDIContainer)
        
        Flows.whenReady(flow1: tabBarFlow) { root in
            self.window!.rootViewController = root
            self.window!.makeKeyAndVisible()
        }
        
        self.coordinator.coordinate(flow: tabBarFlow, with: OneStepper(withSingleStep: MovieStep.showMovieListView))
        return true
    }
    
}

