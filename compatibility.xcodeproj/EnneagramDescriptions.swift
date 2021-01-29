//
//  EnneagramDescriptions.swift
//  compatibility
//
//  Created by Kyra Lee on 1/29/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import Foundation
import UIKit

class EnneagramDescriptions {
    var enneagram: String!
    var nickname: String!
    var overall: String!
    var fear: String!
    var desire: String!
    var motive: String!
    
    init(enneagram: String, nickname: String, overall: String, fear: String, desire: String, motive: String) {
        self.enneagram = enneagram
        self.nickname = nickname
        self.overall = overall
        self.fear = fear
        self.desire = desire
        self.motive = motive
    }
}
