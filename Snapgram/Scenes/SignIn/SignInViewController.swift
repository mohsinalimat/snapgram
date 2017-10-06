//
//  SignInViewController.swift
//  Snapgram
//
//  Created by Guilherme Souza on 15/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SignInViewController: UIViewController {

    private let viewModel: SignInViewModelType = SignInViewModel(authService: FirebaseAuthService())
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.output.isFormValid.bind(to: signInButton.rx.isEnabled).disposed(by: disposeBag)
    }

    @objc private func signInTapped(_ sender: UIButton) {
        viewModel.input.signInTapped()
    }

    @objc private func emailTextFieldChanged(_ textField: UITextField) {
        viewModel.input.emailChanged(textField.text)
    }

    @objc private func passwordTextFieldChanged(_ textField: UITextField) {
        viewModel.input.passwordChanged(textField.text)
    }

    // MARK: - UI
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: UI Components
    fileprivate lazy var containerView: UIView = UIView()
    fileprivate lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        return imageView
    }()

    fileprivate lazy var fieldsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()

    fileprivate lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    fileprivate lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.tintColor = UIColor.rgba(1, 22, 39)
        return textField
    }()

    fileprivate lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.tintColor = UIColor.rgba(1, 22, 39)
        return textField
    }()

    fileprivate lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.addTarget(self, action: #selector(signInTapped(_:)), for: .touchUpInside)
        return button
    }()

    fileprivate lazy var createAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = .white
        return label
    }()

    fileprivate lazy var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create account", for: .normal)
        return button
    }()

}

// MARK: - UI Configuration
extension SignInViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(fieldsContainerView)
        fieldsContainerView.addSubview(emailTextField)
        fieldsContainerView.addSubview(separatorView)
        fieldsContainerView.addSubview(passwordTextField)
        containerView.addSubview(signInButton)
        containerView.addSubview(createAccountLabel)
        containerView.addSubview(createAccountButton)
    }

    func setupConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.right.greaterThanOrEqualToSuperview().offset(-12).priority(999)
            make.left.greaterThanOrEqualToSuperview().offset(12).priority(999)
            make.width.lessThanOrEqualTo(400)
        }
        logoImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(fieldsContainerView.snp.top).offset(-48)
            make.width.equalToSuperview()
            make.height.equalTo(128) // test
            make.centerX.equalToSuperview()
        }

        fieldsContainerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }

        emailTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(44)
        }

        separatorView.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(1)
        }

        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(separatorView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(44)
        }

        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(fieldsContainerView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }

        createAccountLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalTo(createAccountButton)
        }

        createAccountButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    func configureView() {
        view.tintColor = .white
        view.backgroundColor = UIColor.rgba(1, 22, 39)
    }
}
