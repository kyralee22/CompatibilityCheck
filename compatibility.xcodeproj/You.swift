//
//  You.swift
//  compatibility
//
//  Created by Kyra Lee on 1/25/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import Foundation
import UIKit

class You {
    
    var pic: UIImage!
    var name: String!
    var horoscope: String!
    var myersbriggs: String!
    var enneagram: String!
    
    init(pic: UIImage, name: String, horoscope: String, myersbriggs: String, enneagram: String) {
        self.pic = pic
        self.name = name
        self.horoscope = horoscope
        self.myersbriggs = myersbriggs
        self.enneagram = enneagram
    }
    
//    You(pic: UIImage(named: "noPFP")!, name: "name", horoscope: "zodiac sign", myersbriggs: "personality type", enneagram: "0")
    
    func isDefault() -> Bool {
        return (self.pic == UIImage(named: "noPFP")) &&
            (self.name == "name") &&
            (self.horoscope == "zodiac sign") &&
            (self.myersbriggs == "personality type") &&
            (self.enneagram == "0")
    }
}
