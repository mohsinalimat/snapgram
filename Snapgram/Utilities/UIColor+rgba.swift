//
//  UIColor+rgba.swift
//  Snapgram
//
//  Created by Guilherme Souza on 16/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
