//
//  ApiConnection.swift
//  VIPPER
//
//  Created by Manh Pham on 3/16/21.
//

import Foundation
import Moya
import RxSwift

final class ApiConnection {

    static let shared = ApiConnection()
    private init() {}
    
    private func makeProvider() -> ApiProvider<MultiTarget> {
        var plugins = [PluginType]()
        if let token = AuthManager.shared.token {
            let tokenClosure: (AuthorizationType) -> String = { type in
                return token
            }
            let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure)
            plugins.append(authPlugin)
        }
        let apiProvider = ApiProvider<MultiTarget>(plugins: plugins)
        return apiProvider
    }
    
}

extension ApiConnection {

    func request<T: Codable>(target: MultiTarget, type: T.Type) -> Observable<T> {
        return makeProvider().request(target: target).map(T.self)
    }

    func requestArray<T: Codable>(target: MultiTarget, type: T.Type) -> Observable<[T]> {
        return makeProvider().request(target: target).map([T].self)
    }

}