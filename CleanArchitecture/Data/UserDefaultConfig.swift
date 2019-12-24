//
//  UserDefaultConfig.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 24/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import Foundation

struct UserDefaultsConfig {
    @UserDefault(key: "HAS_SEEN_TUTORIAL", defaultValue: false)
    static var hasSeenTutorial: Bool
}
