//
//  GETTokenUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 11/28/21.
//

import Foundation

protocol GETTokenUseCaseInterface {
    func getToken() -> String?
}

final class GETTokenUseCase {
    @Injected var repo: UserRepositoryInterface
}

extension GETTokenUseCase: GETTokenUseCaseInterface {
    func getToken() -> String? {
        repo.token
    }
}