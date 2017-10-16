//
//  AuthService.swift
//  Snapgram
//
//  Created by Guilherme Souza on 15/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAuth

enum AuthError: Error {
    case custom(String)
    case invalidCredentials
}

protocol AuthServiceProvider {
    func signIn(email: String, password: String) -> Observable<User>
}
