//
//  Resources.swift
//  compatibility
//
//  Created by Kyra Lee on 1/25/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import Foundation
import UIKit

class Resources {
    
    var purple: UIColor = UIColor(red: 0.70, green: 0.53, blue: 0.62, alpha: 1.00)
    var seagreen: UIColor = UIColor(red: 0.22, green: 0.70, blue: 0.62, alpha: 1.00)
    var yellow: UIColor = UIColor(red: 0.90, green: 0.79, blue: 0.16, alpha: 1.00)
    var blue: UIColor = UIColor(red: 0.37, green: 0.75, blue: 0.84, alpha: 1.00)
    var red: UIColor = UIColor(red: 0.75, green: 0.13, blue: 0.17, alpha: 1.00)
    
    var lightPurple: UIColor = UIColor(red: 0.91, green: 0.86, blue: 0.89, alpha: 1.00)
    var lightSeagreen: UIColor = UIColor(red: 0.84, green: 0.94, blue: 0.93, alpha: 1.00)
    var lightYellow: UIColor = UIColor(red: 0.99, green: 0.95, blue: 0.68, alpha: 1.00)
    var lightRed: UIColor = UIColor(red: 0.98, green: 0.51, blue: 0.47, alpha: 1.00)
    var lightBlue: UIColor = UIColor(red: 0.87, green: 0.95, blue: 0.97, alpha: 1.00)
    
    var darkPurple: UIColor = UIColor(red: 0.40, green: 0.13, blue: 0.36, alpha: 1.00)
    var darkSeagreen: UIColor = UIColor(red: 0.13, green: 0.42, blue: 0.37, alpha: 1.00)
    var darkYellow: UIColor = UIColor(red: 0.60, green: 0.47, blue: 0.01, alpha: 1.00)
    var darkBlue: UIColor = UIColor(red: 0.00, green: 0.34, blue: 0.54, alpha: 1.00)
    var darkRed: UIColor = UIColor(red: 0.47, green: 0.00, blue: 0.05, alpha: 1.00)
    
    var grey: UIColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
    var lightGrey: UIColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
    
    let headerFont: UIFont! = UIFont(name: "Goldoni", size: 40.0)
    let responseFont: UIFont! = UIFont(name: "Mighty", size: 50.0)
    let numbersFont: UIFont! = UIFont(name: "CasanovaSerifDisplayFree-Regula", size: 15.0) // 07x5 // 1000WishesOrigami
    let initalsFont: UIFont! = UIFont(name: "Blink", size: 40.0)
    
    func determineColor(percent: Int, which: String) -> UIColor {
        if (percent >= 0) && (percent <= 33) {
            if which == "comp"{
                return red
            }
            return darkRed
        }
        if (percent > 33) && (percent <= 75) {
            if which == "comp" {
                return yellow
            }
            return darkYellow
        } else {
            if which == "comp" {
                return blue
            }
            return darkBlue
        }
    }
}

