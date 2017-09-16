//
//  SignInViewModel.swift
//  Snapgram
//
//  Created by Guilherme Souza on 15/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol SignInViewModelInputs {
    func emailChanged(_ value: String)
    func passwordChanged(_ value: String)
}

protocol SignInViewModelOutputs {
//    var successfullySignedIn: Signal<Bool, NoError> { get }
//    var errorMessage: Signal<String, NoError> { get }
//    var isFormValid: Signal<Bool, NoError> { get }
}

protocol SignInViewModelType {
    var input: SignInViewModelInputs { get }
    var output: SignInViewModelOutputs { get }
}

struct SignInViewModel: SignInViewModelType, SignInViewModelInputs, SignInViewModelOutputs {
//    let successfullySignedIn: Signal<Bool, NoError>
//    let errorMessage: Signal<String, NoError>
//    let isFormValid: Signal<Bool, NoError>

    private let authService: AuthServiceProvider

    init(authService: AuthServiceProvider) {
        self.authService = authService

//        successfullySignedIn = Signal.zip(emailProperty.signal.skipNil(), passowordProperty.signal.skipNil())
//            .flatMap(FlattenStrategy.race, self.authService.signIn)

    }

    private let emailProperty = MutableProperty<String?>(nil)
    func emailChanged(_ value: String) {
        emailProperty.value = value
    }

    private let passowordProperty = MutableProperty<String?>(nil)
    func passwordChanged(_ value: String) {
        passowordProperty.value = value
    }

    var input: SignInViewModelInputs { return self }
    var output: SignInViewModelOutputs { return self }
}
