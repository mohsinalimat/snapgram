//
//  SignInViewModelTest.swift
//  SnapgramTests
//
//  Created by Guilherme Souza on 05/10/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import Quick
import Nimble
import RxSwift

@testable import Snapgram

class SignInViewModelTest: QuickSpec {
    
    override func spec() {

        var sut: SignInViewModel!
        var disposeBag: DisposeBag!

        beforeEach {
            sut = SignInViewModel(authService: AuthServiceMock())
            disposeBag = DisposeBag()
        }

        describe("SignIn") {
            context("valid") {
                it("returns signed user") {
                    var successfullyLoggedIn = false

                    sut.succesfullySignedIn.subscribe(onNext: { (value) in
                        successfullyLoggedIn = value
                    }).disposed(by: disposeBag)

                    sut.emailChanged("test@gmail.com")
                    sut.passwordChanged("123456")

                    expect(successfullyLoggedIn).toEventually(beTrue())
                }
            }
        }

        describe("Form validation") {
            context("Not valid ", {
                it("Return not valid when email isn't properly filled") {
                    var isValid = true

                    sut.isFormValid.subscribe(onNext: { (value) in
                        isValid = value
                    }).disposed(by: disposeBag)

                    sut.emailChanged("test")
                    sut.passwordChanged("123456")

                    expect(isValid).toEventually(beFalse())
                }

                it("Return not valid when password has less than 6 characters") {
                    var isValid = true

                    sut.isFormValid.subscribe(onNext: { (value) in
                        isValid = value
                    }).disposed(by: disposeBag)

                    sut.emailChanged("valid@email.com")
                    sut.passwordChanged("5")

                    expect(isValid).toEventually(beFalse())
                }
            })

            context("Valid", {
                it("Return valid when fields are properly fileed") {
                    var isValid = false

                    sut.isFormValid.subscribe(onNext: { (value) in
                        isValid = value
                    }).disposed(by: disposeBag)

                    sut.emailChanged("valid@email.com")
                    sut.passwordChanged("123456")

                    expect(isValid).toEventually(beTrue())
                }
            })
        }

    }

}
