//
//  FirebaseAuthService.swift
//  Snapgram
//
//  Created by Guilherme Souza on 16/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import Foundation
import FirebaseAuth
import RxSwift

final class FirebaseAuthService: AuthServiceProvider {

    private let auth = Auth.auth()

    func signIn(email: String, password: String) -> Observable<User> {
        return auth.rx_signIn(withEmail: email, password: password)
            .flatMap { user -> Observable<User> in
                guard let user = user else {
                    return Observable.error(AuthError.custom(""))
                }

                return Observable.just(User(user: user))
            }
    }
}
