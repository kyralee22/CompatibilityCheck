//
//  csvRead.swift
//  compatibility
//
//  Created by Kyra Lee on 1/25/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import Foundation

class csvRead {
    
    var horoCSV: [String: Float]!
    var myersCSV: [String: Float]!
    var enneaCSV: [String: Float]!
    
    var myersDescript: [String:[String:String]]!
    var enneaDescript: [String:[String:String]]!
    
    
    init(){
        let horoArray = csv(data: cleanRows(file: readDataFromCSV(fileName: "Horo", fileType: ".csv")!))
        let myersArray = csv(data: cleanRows(file: readDataFromCSV(fileName: "MBTI", fileType: ".csv")!))
        let enneaArray = csv(data: cleanRows(file: readDataFromCSV(fileName: "Ennea", fileType: ".csv")!))
        
        let myersDescriptArray = csv(data: cleanRows(file: readDataFromCSV(fileName: "MBTIDescriptions", fileType: ".csv")!))
        let enneaDescriptArray = csv(data: cleanRows(file: readDataFromCSV(fileName: "enneagramDescriptions", fileType: ".csv")!))
        
        horoCSV = toDict(file: horoArray)
        myersCSV = toDict(file: myersArray)
        enneaCSV = toDict(file: enneaArray)
        
        myersDescript = myersToDict(array: myersDescriptArray)
        enneaDescript = enneaToDict(array: enneaDescriptArray)
//
//        print("myers description \(myersDescriptArray[1][0])")
     //   print("ennea description \(enneaDescriptArray[1][0])")
    }
    
    func getMyersDescript() -> [String:[String:String]] {
        return myersDescript
    }
    
    func getEnneaDescript() -> [String:[String:String]] {
        return enneaDescript
    }
    
    func compareHoroscopes(yours: String, theirs: String) -> Float {
        let combo = yours.capitalizingFirstLetter() + theirs.capitalizingFirstLetter()
        return horoCSV[combo] ?? 0
    }
    
    func compareMBTI(yours: String, theirs: String) -> Float {
        let combo = yours.uppercased() + "-" + theirs.uppercased()
        return myersCSV[combo] ?? myersCSV[theirs.uppercased() + "-" + yours.uppercased()] ?? 0
    }
    
    func compareEnneagrams(yours: String, theirs: String) -> Float {
        let combo = yours + ":" + theirs
        return enneaCSV[combo] ?? 0
    }
    
    func compareOverall(horo: Int, myers: Int, ennea: Int) -> Int {
        var count = 0
        if horo != 0 {
            count += 1
        }
        if myers != 0 {
            count += 1
        }
        if ennea != 0 {
            count += 1
        }
        return (horo + myers + ennea) / count
    }
    
    func toDict(file: [[String]]) -> [String: Float] {
        var newDict = [String: Float]()
        for each in 1..<file.count {
            let element = file[each][0]
            let index = element.indexOf(character: ",")
            let key = element[0..<index]
            let value = element[(index+1)...]
            newDict[key] = Float(value)
        }
        return newDict
    }
    
    func myersToDict(array: [[String]]) -> [String:[String:String]] {
        var dict = [String:[String:String]]()
        for each in 1..<array.count {
            let full = array[each][0]
            let temp = separateCommas(text: full, num: 2)
            let tempDict = ["Nickname":temp[1], "Description":temp[2]]
            dict[temp[0]] = tempDict
        }
        return dict
    }
    
    func enneaToDict(array: [[String]]) -> [String:[String:String]] {
        var dict = [String:[String:String]]()
        for each in 1..<array.count {
            let full = array[each][0]
            if full.count > 0 {
                let temp = separateCommas(text: full, num: 2)
                let remainder = temp[2]
                let description = remainder[0..<remainder.indexOf(character: "1")]
                let fear = remainder[(remainder.indexOf(character: "1")+1)..<remainder.indexOf(character: "2")]
                let desire = remainder[(remainder.indexOf(character: "2")+1)..<remainder.indexOf(character: "3")]
                let motive = remainder[(remainder.indexOf(character: "3")+1)...]
                let tempDict = ["Nickname":temp[1], "Description":description, "Basic Fear":fear, "Basic Desire":desire, "Key Motivation":motive]
                dict[temp[0]] = tempDict
            }
        }
        return dict
    }
    
    func separateCommas(text: String, num: Int) -> [String] {
        var array = [String]()
        var temp = ""
        var count = 0
        var index = 0
        for letter in text {
            if count < num {
                if letter == "," {
                    array.append(temp)
                    temp = ""
                    count += 1
                } else {
                    temp = temp + String(letter)
                }
                index += 1
            } else {
                array.append(text[index...])
                return array
            }
        }
        return array
    }
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
            guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
                else {
                    return nil
            }
            do {
                var contents = try String(contentsOfFile: filepath, encoding: .utf8)
                contents = cleanRows(file: contents)
                return contents
            } catch {
                print("File Read Error for file \(filepath)")
                return nil
            }
        }


    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
        return cleanFile
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ";")
            result.append(columns)
        }
        return result
    }
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func indexOf(character: Character) -> Int {
        var count = 0
        for x in self{
            if x == character{
                return count
            } else {
                count += 1
            }
        }
        return 0
    }
}
