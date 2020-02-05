//
//  Color+.swift
//  LinkedPageExample
//
//  Created by Olgu on 5.02.2020.
//  Copyright © 2020 Aspendos IT. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
