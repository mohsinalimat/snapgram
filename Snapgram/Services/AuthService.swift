//
//  AuthService.swift
//  Snapgram
//
//  Created by Guilherme Souza on 15/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import Foundation
import ReactiveSwift

enum AuthError: Error {
    case custom(String)
}

protocol AuthServiceProvider {
    func signIn(email: String, password: String) -> Signal<User?, AuthError>
}
