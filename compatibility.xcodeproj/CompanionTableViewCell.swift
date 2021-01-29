//
//  CompanionTableViewCell.swift
//  compatibility
//
//  Created by Kyra Lee on 1/25/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class CompanionTableViewCell: UITableViewCell {

    var companion: Companion!
    var name: UILabel!
    var horoSymbol: UIImageView!
    var myersSymbol: UIImageView!
    var enneaSymbol: UIImageView!
    var horoComp: UILabel!
    var myersComp: UILabel!
    var enneaComp: UILabel!
    var overallComp: UILabel!
    
    var picHeight: CGFloat!
    var padding: CGFloat!
    let resources: Resources = Resources()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = resources.lightSeagreen
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for companion: Companion) {
        self.companion = companion
        
        setUpViews()
        
        //let spaceLeft = self.frame.size.width - name.frame.size.width - 40
        picHeight = self.contentView.frame.size.height - 40
        let symbolWidth = picHeight * 3
        let nameWidth = UILabel.textWidth(font: resources.headerFont, text: name.text!)
        let horoWidth = UILabel.textWidth(font: resources.numbersFont.withSize(25), text: horoComp.text!)
        let myersWidth = UILabel.textWidth(font: resources.numbersFont.withSize(25), text: myersComp.text!)
        let enneaWidth = UILabel.textWidth(font: resources.numbersFont.withSize(25), text: enneaComp.text!)
        let overallWidth = UILabel.textWidth(font: resources.numbersFont.withSize(36), text: overallComp.text!)
        let compWidth = nameWidth + horoWidth + myersWidth + enneaWidth + overallWidth
        let otherElements = symbolWidth + compWidth
        padding = (self.contentView.frame.size.width - 10 - otherElements) / 10 // check

        setUpConstraints()
        
    }
    
    func getInitials(name: String) -> String {
        let index = name.indexOf(character: " ")
        let firstLet = name[0..<1]
        let secondLet = name[(index+1)..<(index+2)]
        return "\(firstLet.uppercased() ?? "X").\(secondLet.uppercased() ?? "X")"
    }
    
    func setUpViews(){
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textAlignment = .center
        let compName = companion.name
        name.text = getInitials(name: compName ?? "their full name")
        name.font = resources.headerFont
     //   name.backgroundColor = UIColor(red: 0.92, green: 0.97, blue: 0.96, alpha: 1.00)
        name.textColor = resources.seagreen
        self.contentView.addSubview(name)
        
        var horoImage: String!
        var myersImage: String!
        
        if companion.horoscope == "their horoscope"{ horoImage = "zodiac sign"
        } else { horoImage = companion.horoscope ?? "zodiac sign"}
        
        if companion.myersbriggs == "their personality type"{ myersImage = "personality type"
        } else { myersImage = companion.myersbriggs ?? "personality type"}
        
        horoSymbol = UIImageView(image: UIImage(named: horoImage))
        horoSymbol.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(horoSymbol)
        
        myersSymbol = UIImageView(image: UIImage(named: myersImage))
        myersSymbol.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(myersSymbol)
        
        enneaSymbol = UIImageView(image: UIImage(named: "\(companion.enneagram ?? "0")"))
        enneaSymbol.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(enneaSymbol)
        
        horoComp = UILabel()
        horoComp.translatesAutoresizingMaskIntoConstraints = false
        horoComp.text = "\(companion.horoComp ?? 0)%"
        horoComp.font = resources.numbersFont.withSize(25)
        horoComp.textAlignment = NSTextAlignment.center
        horoComp.textColor = resources.seagreen
        self.contentView.addSubview(horoComp)
        
        myersComp = UILabel()
        myersComp.translatesAutoresizingMaskIntoConstraints = false
        myersComp.text = "\(companion.myersComp ?? 0)%"
        myersComp.font = resources.numbersFont.withSize(25)
        myersComp.textAlignment = NSTextAlignment.center
        myersComp.textColor = resources.seagreen
        self.contentView.addSubview(myersComp)
        
        enneaComp = UILabel()
        enneaComp.translatesAutoresizingMaskIntoConstraints = false
        enneaComp.text = "\(companion.enneaComp ?? 0)%"
        enneaComp.font = resources.numbersFont.withSize(25)
        enneaComp.textAlignment = NSTextAlignment.center
        enneaComp.textColor = resources.seagreen
        self.contentView.addSubview(enneaComp)
        
        overallComp = UILabel()
        overallComp.translatesAutoresizingMaskIntoConstraints = false
        overallComp.text = "\(companion.overallComp ?? 0)%"
        overallComp.font = resources.numbersFont.withSize(36)
        overallComp.textAlignment = NSTextAlignment.center
        overallComp.textColor = resources.determineColor(percent: companion.overallComp, which: "comp")
        self.contentView.addSubview(overallComp)
    }
    
    func setUpConstraints() {
                
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            overallComp.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: padding),
            overallComp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            horoSymbol.heightAnchor.constraint(equalToConstant: picHeight),
            horoSymbol.widthAnchor.constraint(equalToConstant: picHeight),
            horoSymbol.leadingAnchor.constraint(equalTo: overallComp.trailingAnchor, constant: padding),
            horoSymbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            horoComp.leadingAnchor.constraint(equalTo: horoSymbol.trailingAnchor, constant: padding),
            horoComp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5)
        ])

        NSLayoutConstraint.activate([
            myersSymbol.heightAnchor.constraint(equalToConstant: picHeight),
            myersSymbol.widthAnchor.constraint(equalToConstant: picHeight),
            myersSymbol.leadingAnchor.constraint(equalTo: horoComp.trailingAnchor, constant: padding),
            myersSymbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            myersComp.leadingAnchor.constraint(equalTo: myersSymbol.trailingAnchor, constant: padding),
            myersComp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5)
        ])

        NSLayoutConstraint.activate([
            enneaSymbol.heightAnchor.constraint(equalToConstant: picHeight),
            enneaSymbol.widthAnchor.constraint(equalToConstant: picHeight),
            enneaSymbol.leadingAnchor.constraint(equalTo: myersComp.trailingAnchor, constant: padding),
            enneaSymbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            enneaComp.leadingAnchor.constraint(equalTo: enneaSymbol.trailingAnchor, constant: padding),
            enneaComp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5)
        ])

    }
}
