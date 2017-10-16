//
//  AuthServiceMock.swift
//  SnapgramTests
//
//  Created by Guilherme Souza on 05/10/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import Foundation
import RxSwift

@testable import Snapgram

final class AuthServiceMock: AuthServiceProvider {
    func signIn(email: String, password: String) -> Observable<User> {
        if email == "test@gmail.com" && password == "123456" {
            let user = User(uid: "asdfg", email: email)
            
            return Observable.just(user)
        }
        return Observable.error(AuthError.invalidCredentials)
    }
}
