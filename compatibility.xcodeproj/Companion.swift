//
//  Companion.swift
//  compatibility
//
//  Created by Kyra Lee on 1/25/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import Foundation
import UIKit

class Companion {
    
    var pic: UIImage!
    var name: String!
    var horoscope: String!
    var myersbriggs: String!
    var enneagram: String!
    var horoComp: Int!
    var myersComp: Int!
    var enneaComp: Int!
    var overallComp: Int!
    var doDelete: Bool!
    
    let csv: csvRead = csvRead()
    
    init(pic: UIImage, name: String, horoscope: String, myersbriggs: String, enneagram: String, doDelete: Bool){
        self.pic = pic
        self.name = name
        self.horoscope = horoscope
        self.myersbriggs = myersbriggs
        self.enneagram = enneagram
        self.doDelete = doDelete
    }
    
    func configure(you: You){
        horoComp = Int(csv.compareHoroscopes(yours: you.horoscope, theirs: horoscope))
        myersComp = Int(csv.compareMBTI(yours: you.myersbriggs, theirs: myersbriggs))
        enneaComp = Int(csv.compareEnneagrams(yours: you.enneagram, theirs: enneagram))
        overallComp = csv.compareOverall(horo: horoComp, myers: myersComp, ennea: enneaComp)
    }
    
    func setDelete(delete: Bool) {
        doDelete = delete
    }
    
    func getDelete() -> Bool {
        return doDelete
    }
    
    func equals(companion: Companion) -> Bool {
        return
            self.name == companion.name &&
            self.horoscope == companion.horoscope &&
            self.myersbriggs == companion.myersbriggs &&
            self.enneagram == companion.enneagram
        
    }
}

