//
//  SignInViewController.swift
//  Snapgram
//
//  Created by Guilherme Souza on 15/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit
import SnapKit

final class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - UI Components
    fileprivate lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        return imageView
    }()

    fileprivate lazy var containerView: UIView = {
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
        return textField
    }()

    fileprivate lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()

    fileprivate lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        return button
    }()

}

// MARK: - UI Configuration
extension SignInViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(logoImageView)
        view.addSubview(containerView)
        containerView.addSubview(emailTextField)
        containerView.addSubview(separatorView)
        containerView.addSubview(passwordTextField)
        view.addSubview(signInButton)
    }

    func setupConstraints() {
        logoImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(containerView.snp.top).offset(-48)
            make.width.equalTo(containerView)
            make.height.equalTo(128) // test
            make.centerX.equalToSuperview()
        }

        containerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.right.greaterThanOrEqualToSuperview().offset(-12).priority(999)
            make.left.greaterThanOrEqualToSuperview().offset(12).priority(999)
            make.width.lessThanOrEqualTo(400)
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
            make.top.equalTo(containerView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }

    func configureView() {
        view.backgroundColor = .lightGray
    }
}
