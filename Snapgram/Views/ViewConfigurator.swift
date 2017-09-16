//
//  ViewConfigurator.swift
//  Snapgram
//
//  Created by Guilherme Souza on 16/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import Foundation

protocol ViewConfigurator {
    func buildViewHierarchy()
    func setupConstraints()
    func configureView()
}

extension ViewConfigurator {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        configureView()
    }
}
