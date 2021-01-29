//
//  MBTIDescriptions.swift
//  compatibility
//
//  Created by Kyra Lee on 1/29/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import Foundation
import UIKit

class MBTIDescriptions {
    let resources: Resources = Resources()
    
    var type: String!
    var nickname: String!
    var description: String!
    var color: UIColor!
    
    init(type: String, nickname: String, description: String) {
        self.type = type.lowercased()
        self.nickname = nickname
        self.description = description
        self.color = determineColor(MBTItype: self.type)
    }
    
    func determineColor(MBTItype: String) -> UIColor {
        if (MBTItype == "enfj") || (MBTItype == "enfp") || (MBTItype == "infj") || (MBTItype == "infp") {
            return resources.seagreen
        } else if (MBTItype == "entj") || (MBTItype == "entp") || (MBTItype == "intj") || (MBTItype == "intp") {
            return resources.purple
        } else if (MBTItype == "esfj") || (MBTItype == "estj") || (MBTItype == "isfj") || (MBTItype == "istj") {
            return resources.blue
        } else if (MBTItype == "esfp") || (MBTItype == "estp") || (MBTItype == "isfp") || (MBTItype == "istp") {
            return resources.yellow
        }
        return .gray
    }
}
