//
//  SignInViewModel.swift
//  Snapgram
//
//  Created by Guilherme Souza on 15/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SignInViewModelInputs {
    func emailChanged(_ value: String?)
    func passwordChanged(_ value: String?)

    func signInTapped()
}

protocol SignInViewModelOutputs {
    var succesfullySignedIn: Observable<Bool> { get }
    var isFormValid: Observable<Bool> { get }
}

protocol SignInViewModelType {
    var input: SignInViewModelInputs { get }
    var output: SignInViewModelOutputs { get }
}

struct SignInViewModel: SignInViewModelType, SignInViewModelInputs, SignInViewModelOutputs {
    let succesfullySignedIn: Observable<Bool>
    let isFormValid: Observable<Bool>

    private let authService: AuthServiceProvider

    init(authService: AuthServiceProvider) {
        self.authService = authService

        let emailAndPassword = Observable.combineLatest(email.asObservable().skipNil(), password.asObservable().skipNil())

        isFormValid = emailAndPassword.map(validateFields)

        succesfullySignedIn = signInProperty.asObservable()
            .withLatestFrom(isFormValid)
            .filter{ $0 == true}
            .flatMap { _ in emailAndPassword }
            .flatMap(authService.signIn)
            .map { _ in true }
            .catchErrorJustReturn(false)
    }

    private let email: Variable<String?> = Variable(nil)
    func emailChanged(_ value: String?) {
        email.value = value
    }

    private let password: Variable<String?> = Variable(nil)
    func passwordChanged(_ value: String?) {
        password.value = value
    }

    private let signInProperty = Variable()
    func signInTapped() {
        signInProperty.value = ()
    }

    var input: SignInViewModelInputs { return self }
    var output: SignInViewModelOutputs { return self }
}

private func validateFields(email: String, password: String) -> Bool {
    return isEmailValid(email) && isPasswordValid(password)
}

private func isEmailValid(_ email: String) -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: email)
}

private func isPasswordValid(_ password: String) -> Bool {
    return password.count > 5
}
