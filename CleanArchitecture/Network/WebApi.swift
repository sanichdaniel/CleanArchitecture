//
//  WebApi.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 13/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//

import Moya
import CommonCrypto

enum WebAPI {
    case searchMovies(title: String)
}

extension WebAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://movie-database-imdb-alternative.p.rapidapi.com")!
    }
    
    var path: String {
        switch self {
        case .searchMovies:
            return ""
        }
    }
    
    var method: Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .searchMovies:
            return params
        }
    }
    
    var task: Task {
        switch self {
        case let .searchMovies(title: title):
            return .requestParameters(
                parameters: ["s": title],
                encoding: URLEncoding.default)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "X-RapidAPI-KEY": "c858b3f6c9msh78f864d7389000ep1bdd5bjsndbac00a75da3"]
    }
    
}

