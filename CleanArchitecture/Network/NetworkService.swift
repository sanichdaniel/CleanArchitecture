//
//  NetworkService.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 12/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//
import Foundation
import Moya
import RxSwift
import Alamofire

enum Resource<T> {
    case Success(T)
    case Failure(String?)
    
    func getData() -> T? {
        switch self {
        case let .Success(data):
            return data
        case .Failure:
            return nil
        }
    }
}

typealias CANetwork = Network<WebAPI>

final class Network<Target> where Target: Moya.TargetType {
    fileprivate let provider: MoyaProvider<Target>
    
    init(plugins: [PluginType] = []) {
        self.provider = MoyaProvider(plugins: plugins)
    }
    
    func request<T: Codable>(_ target: Target, responseType: T.Type) -> Single<Resource<T>> {
        return provider.rx.request(target)
            .flatMap { response -> Single<Resource<T>> in
                do {
                    let decoder = JSONDecoder()
                    let value = try decoder.decode(T.self, from: response.data)
                    return Single.just(.Success(value))
                } catch {
                    return Single.just(.Failure("ERROR"))
                }
        }
    }
    
}
