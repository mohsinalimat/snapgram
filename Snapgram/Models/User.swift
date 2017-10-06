//
//  User.swift
//  Snapgram
//
//  Created by Guilherme Souza on 16/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import Foundation
import Marshal
import FirebaseAuth

struct User {
    let uid: String
    let email: String?
}

extension User: Unmarshaling, Marshaling {
    init(object: MarshaledObject) throws {
        uid = try object.value(for: "uid")
        email = try? object.value(for: "email")
    }
    func marshaled() -> [String: Any?] {
        return [
            "uid": uid,
            "email": email
        ]
    }
}

extension User {
    init(user: FirebaseAuth.User) {
        uid = user.uid
        email = user.email
    }
}
