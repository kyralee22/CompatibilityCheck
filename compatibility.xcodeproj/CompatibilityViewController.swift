//
//  CompatibilityViewController.swift
//  compatibility
//
//  Created by Kyra Lee on 1/26/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class CompatibilityViewController: UIViewController {
    
    let resources: Resources = Resources()
    var companion: Companion!
    var you: You!
    var third: CGFloat!
    var mid: CGFloat!
    var titleLabel: UILabel!
    let picHeight: CGFloat = 50.0
    
    var overall: UILabel!
    var horoscope: UILabel!
    var myersbriggs: UILabel!
    var enneagram: UILabel!
    
    var youLabel: UILabel!
    var youPic: UIImageView!
    var themLabel: UILabel!
    var themPic: UIImageView!
    
    var youHoro: UILabel!
    var youMyers: UILabel!
    var youEnnea: UILabel!
    var youHoroPic: UIImageView!
    var youMyersPic: UIImageView!
    var youEnneaPic: UIImageView!
    
    var themHoro: UILabel!
    var themMyers: UILabel!
    var themEnnea: UILabel!
    var themHoroPic: UIImageView!
    var themMyersPic: UIImageView!
    var themEnneaPic: UIImageView!
    
    var overallComp: UILabel!
    var horoComp: UILabel!
    var myersComp: UILabel!
    var enneaComp: UILabel!
    
    weak var delegate: deletePerson!
    var deleteCompanion: UIButton!
            
    init(you: You, companion: Companion, delegate: deletePerson){

        super.init(nibName: nil, bundle: nil)
        
        self.you = you
        self.companion = companion
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        third = (view.frame.size.width / 3) / 2
        mid = view.frame.size.width / 2
        
        // setup nav bar
        view.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = resources.seagreen
        titleLabel.font = resources.headerFont.withSize(25)
        titleLabel.textAlignment = .center
        titleLabel.text = "COMPATIBILITY BREAKDOWN"
        
        self.navigationItem.titleView = titleLabel
        
        setUpViews()
        setUpConstraints()
        
        youPic = UIImageView(image: you.pic)
        youPic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(youPic)
        
        NSLayoutConstraint.activate([
            youPic.heightAnchor.constraint(equalToConstant: 60),
            youPic.widthAnchor.constraint(equalToConstant: 60),
            youPic.trailingAnchor.constraint(equalTo: overallComp.leadingAnchor, constant: -3),
            youPic.centerYAnchor.constraint(equalTo: overallComp.centerYAnchor)
        ])
        youPic.makeRounded()
        
        themPic = UIImageView(image: companion.pic)
        themPic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(themPic)
        
        NSLayoutConstraint.activate([
            themPic.heightAnchor.constraint(equalToConstant: 60),
            themPic.widthAnchor.constraint(equalToConstant: 60),
            themPic.leadingAnchor.constraint(equalTo: overallComp.trailingAnchor, constant: 3),
            themPic.centerYAnchor.constraint(equalTo: overallComp.centerYAnchor)

        ])
        themPic.makeRounded()
        
    }
    
    func defaultValue(text: String) -> String {
        if (text == "zodiac sign") || (text == "their horoscope") {
            return "?"
        }
        if (text == "personality type") || (text == "their personality type") {
            return "?"
        }
        if (text == "0") {
            return "?"
        }
        return text
    }
    
    func setUpViews() {
        
        overall = UILabel()
        overall.translatesAutoresizingMaskIntoConstraints = false
        var overallString:NSString = "OVERALL COMPATIBILITY"
        var mutableString = NSMutableAttributedString()
        mutableString = NSMutableAttributedString(string: overallString as String, attributes: [NSAttributedString.Key.font:resources.headerFont.withSize(26)])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.determineColor(percent: companion.overallComp, which: "comp"), range: NSRange(location:0,length:7))
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.grey, range: NSRange(location:8,length:13))
        overall.attributedText = mutableString
        overall.layer.borderWidth = 3
        overall.layer.borderColor = resources.grey.cgColor
        overall.backgroundColor = resources.lightGrey
        overall.textAlignment = .center
        view.addSubview(overall)
        
        horoscope = UILabel()
        horoscope.translatesAutoresizingMaskIntoConstraints = false
        let horoString:NSString = "HOROSCOPE COMPATIBILITY"
        mutableString = NSMutableAttributedString(string: horoString as String, attributes: [NSAttributedString.Key.font:resources.headerFont.withSize(26)])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.determineColor(percent: companion.horoComp, which: "comp"), range: NSRange(location:0,length:9))
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.grey, range: NSRange(location:10, length:13))
        horoscope.attributedText = mutableString
        horoscope.layer.borderWidth = 3
        horoscope.layer.borderColor = resources.grey.cgColor
        horoscope.backgroundColor = resources.lightGrey
        horoscope.textAlignment = .center
        view.addSubview(horoscope)
        
        myersbriggs = UILabel()
        myersbriggs.translatesAutoresizingMaskIntoConstraints = false
        let myersString:NSString = "MYERS-BRIGGS COMPATIBILITY"
        mutableString = NSMutableAttributedString(string: myersString as String, attributes: [NSAttributedString.Key.font:resources.headerFont.withSize(26)])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.determineColor(percent: companion.myersComp, which: "comp"), range: NSRange(location:0,length:12))
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.grey, range: NSRange(location:13, length:13))
        myersbriggs.attributedText = mutableString
        myersbriggs.layer.borderWidth = 3
        myersbriggs.layer.borderColor = resources.grey.cgColor
        myersbriggs.backgroundColor = resources.lightGrey
        myersbriggs.textAlignment = .center
        view.addSubview(myersbriggs)
        
        enneagram = UILabel()
        enneagram.translatesAutoresizingMaskIntoConstraints = false
        let enneaString:NSString = "ENNEAGRAM COMPATIBILITY"
        mutableString = NSMutableAttributedString(string: enneaString as String, attributes: [NSAttributedString.Key.font:resources.headerFont.withSize(26)])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.determineColor(percent: companion.enneaComp, which: "comp"), range: NSRange(location:0,length:9))
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.grey, range: NSRange(location:10, length:13))
        enneagram.attributedText = mutableString
        enneagram.layer.borderWidth = 3
        enneagram.layer.borderColor = resources.grey.cgColor
        enneagram.backgroundColor = resources.lightGrey
        enneagram.textAlignment = .center
        view.addSubview(enneagram)
                
        youLabel = UILabel()
        youLabel.translatesAutoresizingMaskIntoConstraints = false
        youLabel.text = "you"
        youLabel.font = resources.responseFont.withSize(60)
        youLabel.textColor = resources.purple
        youLabel.textAlignment = .center
        view.addSubview(youLabel)
        
        themLabel = UILabel()
        themLabel.translatesAutoresizingMaskIntoConstraints = false
        let themName = companion.name
        let theirName = themName?[0..<(themName?.indexOf(character: " ") ?? 1)]
        themLabel.text =  theirName?.lowercased() ?? "them"
        themLabel.font = resources.responseFont.withSize(60)
        themLabel.textColor = resources.seagreen
        themLabel.textAlignment = .center
        view.addSubview(themLabel)
        
        youHoro = UILabel()
        youHoro.translatesAutoresizingMaskIntoConstraints = false
        var horoText = defaultValue(text: you.horoscope)
        if horoText.count > 6{
            horoText = "\(horoText[0..<6])."
        }
        youHoro.text = horoText
        youHoro.textColor = resources.purple
        youHoro.font = resources.responseFont.withSize(60)
        youHoro.textAlignment = .center
        view.addSubview(youHoro)
        
        youMyers = UILabel()
        youMyers.translatesAutoresizingMaskIntoConstraints = false
        youMyers.text = (defaultValue(text: you.myersbriggs)).uppercased()
        youMyers.textColor = resources.purple
        youMyers.font = resources.responseFont.withSize(60)
        youMyers.textAlignment = .center
        view.addSubview(youMyers)
        
        youEnnea = UILabel()
        youEnnea.translatesAutoresizingMaskIntoConstraints = false
        youEnnea.text = defaultValue(text: you.enneagram)
        youEnnea.textColor = resources.purple
        youEnnea.font = resources.responseFont.withSize(60)
        youEnnea.textAlignment = .center
        view.addSubview(youEnnea)
        
        youHoroPic = UIImageView(image: UIImage(named: you.horoscope ?? "zodiac sign"))
        youHoroPic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(youHoroPic)
        
        youMyersPic = UIImageView(image: UIImage(named: you.myersbriggs ?? "personality type"))
        youMyersPic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(youMyersPic)
        
        youEnneaPic = UIImageView(image: UIImage(named: you.enneagram ?? "0"))
        youEnneaPic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(youEnneaPic)
        
        themHoro = UILabel()
        themHoro.translatesAutoresizingMaskIntoConstraints = false
        var themHoroText = defaultValue(text: companion.horoscope)
        if themHoroText.count > 6{
            themHoroText = "\(themHoroText[0..<6])."
        }
        themHoro.text = themHoroText
        themHoro.textColor = resources.seagreen
        themHoro.font = resources.responseFont.withSize(60)
        themHoro.textAlignment = .center
        view.addSubview(themHoro)
        
        themMyers = UILabel()
        themMyers.translatesAutoresizingMaskIntoConstraints = false
        themMyers.text = (defaultValue(text:companion.myersbriggs)).uppercased()
        themMyers.textColor = resources.seagreen
        themMyers.font = resources.responseFont.withSize(60)
        themMyers.textAlignment = .center
        view.addSubview(themMyers)
        
        themEnnea = UILabel()
        themEnnea.translatesAutoresizingMaskIntoConstraints = false
        themEnnea.text = defaultValue(text:(companion.enneagram))
        themEnnea.textColor = resources.seagreen
        themEnnea.font = resources.responseFont.withSize(60)
        themEnnea.textAlignment = .center
        view.addSubview(themEnnea)
        
        themHoroPic = UIImageView(image: UIImage(named: companion.horoscope ?? "zodiac sign"))
        themHoroPic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(themHoroPic)
        
        print("their myers briggs is \(companion.myersbriggs)")
        themMyersPic = UIImageView(image: UIImage(named: companion.myersbriggs ?? "personality type"))
        themMyersPic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(themMyersPic)
        
        themEnneaPic = UIImageView(image: UIImage(named: companion.enneagram ?? "0"))
        themEnneaPic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(themEnneaPic)
        
        overallComp = UILabel()
        overallComp.translatesAutoresizingMaskIntoConstraints = false
        overallComp.text = "\(companion.overallComp ?? 0)%"
        overallComp.textAlignment = .center
        overallComp.font = resources.numbersFont.withSize(40)
        overallComp.textColor = resources.determineColor(percent: companion.overallComp, which: "comp")
        view.addSubview(overallComp)
        
        horoComp = UILabel()
        horoComp.translatesAutoresizingMaskIntoConstraints = false
        horoComp.text = "\(companion.horoComp ?? 0)%"
        horoComp.textAlignment = .center
        horoComp.font = resources.numbersFont.withSize(40)
        horoComp.textColor = resources.determineColor(percent: companion.horoComp, which: "comp")
        view.addSubview(horoComp)
        
        myersComp = UILabel()
        myersComp.translatesAutoresizingMaskIntoConstraints = false
        myersComp.text = "\(companion.myersComp ?? 0)%"
        myersComp.textAlignment = .center
        myersComp.font = resources.numbersFont.withSize(40)
        myersComp.textColor = resources.determineColor(percent: companion.myersComp, which: "comp")
        view.addSubview(myersComp)
        
        enneaComp = UILabel()
        enneaComp.translatesAutoresizingMaskIntoConstraints = false
        enneaComp.text = "\(companion.enneaComp ?? 0)%"
        enneaComp.textAlignment = .center
        enneaComp.font = resources.numbersFont.withSize(40)
        enneaComp.textColor = resources.determineColor(percent: companion.enneaComp, which: "comp")
        view.addSubview(enneaComp)
        
        deleteCompanion = UIButton()
        deleteCompanion.translatesAutoresizingMaskIntoConstraints = false
        deleteCompanion.addTarget(self, action: #selector(deleteTheCompanion), for: .touchUpInside)
        deleteCompanion.setTitle("DELETE COMPANION", for: .normal)
        deleteCompanion.setTitleColor(resources.red, for: .normal)
        deleteCompanion.titleLabel?.font = resources.headerFont
        deleteCompanion.titleLabel?.textAlignment = .center
        deleteCompanion.layer.borderWidth = 5
        deleteCompanion.layer.borderColor = resources.red.cgColor
        deleteCompanion.backgroundColor = resources.lightRed
        view.addSubview(deleteCompanion ?? UIButton())
    }
    
    func setUpConstraints() {
        let labelWidth = view.frame.size.width - 20
        
        NSLayoutConstraint.activate([
            deleteCompanion.widthAnchor.constraint(equalToConstant: view.frame.size.width - 10),
            deleteCompanion.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            deleteCompanion.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        let labelHeight = deleteCompanion.intrinsicContentSize.height - 5
        
        NSLayoutConstraint.activate([
            overall.widthAnchor.constraint(equalToConstant: labelWidth),
            overall.heightAnchor.constraint(equalToConstant: labelHeight),
            overall.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            overall.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            overallComp.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            overallComp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
        
        NSLayoutConstraint.activate([
            youLabel.centerYAnchor.constraint(equalTo: overallComp.centerYAnchor),
            youLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: third)
        ])
        
        NSLayoutConstraint.activate([
            themLabel.centerYAnchor.constraint(equalTo: overallComp.centerYAnchor),
            themLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: (-1 * third))
        ])
        
        NSLayoutConstraint.activate([
            horoscope.widthAnchor.constraint(equalToConstant: labelWidth),
            horoscope.heightAnchor.constraint(equalToConstant: labelHeight),
            horoscope.centerYAnchor.constraint(equalTo: overallComp.bottomAnchor, constant: 55),
            horoscope.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            horoComp.topAnchor.constraint(equalTo: themLabel.bottomAnchor, constant: 110),
            horoComp.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            myersbriggs.widthAnchor.constraint(equalToConstant: labelWidth),
            myersbriggs.heightAnchor.constraint(equalToConstant: labelHeight),
            myersbriggs.centerYAnchor.constraint(equalTo: horoComp.bottomAnchor, constant: 55),
            myersbriggs.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            myersComp.topAnchor.constraint(equalTo: horoComp.bottomAnchor, constant: 110),
            myersComp.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            enneagram.widthAnchor.constraint(equalToConstant: labelWidth),
            enneagram.heightAnchor.constraint(equalToConstant: labelHeight),
            enneagram.centerYAnchor.constraint(equalTo: myersComp.bottomAnchor, constant: 55),
            enneagram.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            enneaComp.topAnchor.constraint(equalTo: myersComp.bottomAnchor, constant: 110),
            enneaComp.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            youHoroPic.widthAnchor.constraint(equalToConstant: picHeight),
            youHoroPic.heightAnchor.constraint(equalToConstant: picHeight),
            youHoroPic.trailingAnchor.constraint(equalTo: horoComp.leadingAnchor, constant: -5),
            youHoroPic.centerYAnchor.constraint(equalTo: horoComp.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            youMyersPic.widthAnchor.constraint(equalToConstant: picHeight),
            youMyersPic.heightAnchor.constraint(equalToConstant: picHeight),
            youMyersPic.trailingAnchor.constraint(equalTo: myersComp.leadingAnchor, constant: -3),
            youMyersPic.centerYAnchor.constraint(equalTo: myersComp.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            youEnneaPic.widthAnchor.constraint(equalToConstant: picHeight),
            youEnneaPic.heightAnchor.constraint(equalToConstant: picHeight),
            youEnneaPic.trailingAnchor.constraint(equalTo: enneaComp.leadingAnchor, constant: -3),
            youEnneaPic.centerYAnchor.constraint(equalTo: enneaComp.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            themHoroPic.widthAnchor.constraint(equalToConstant: picHeight),
            themHoroPic.heightAnchor.constraint(equalToConstant: picHeight),
            themHoroPic.leadingAnchor.constraint(equalTo: horoComp.trailingAnchor, constant: 5),
            themHoroPic.centerYAnchor.constraint(equalTo: horoComp.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            themMyersPic.widthAnchor.constraint(equalToConstant: picHeight),
            themMyersPic.heightAnchor.constraint(equalToConstant: picHeight),
            themMyersPic.leadingAnchor.constraint(equalTo: myersComp.trailingAnchor, constant: 3),
            themMyersPic.centerYAnchor.constraint(equalTo: myersComp.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            themEnneaPic.widthAnchor.constraint(equalToConstant: picHeight),
            themEnneaPic.heightAnchor.constraint(equalToConstant: picHeight),
            themEnneaPic.leadingAnchor.constraint(equalTo: enneaComp.trailingAnchor, constant: 3),
            themEnneaPic.centerYAnchor.constraint(equalTo: enneaComp.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            youHoro.centerYAnchor.constraint(equalTo: horoComp.centerYAnchor),
            youHoro.centerXAnchor.constraint(equalTo: youLabel.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            youMyers.centerYAnchor.constraint(equalTo: myersComp.centerYAnchor),
            youMyers.centerXAnchor.constraint(equalTo: youLabel.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            youEnnea.centerYAnchor.constraint(equalTo: enneaComp.centerYAnchor),
            youEnnea.centerXAnchor.constraint(equalTo: youLabel.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            themHoro.centerYAnchor.constraint(equalTo: youHoro.centerYAnchor),
            themHoro.centerXAnchor.constraint(equalTo: themLabel.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            themMyers.centerYAnchor.constraint(equalTo: youMyers.centerYAnchor),
            themMyers.centerXAnchor.constraint(equalTo: themLabel.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            themEnnea.centerYAnchor.constraint(equalTo: youEnnea.centerYAnchor),
            themEnnea.centerXAnchor.constraint(equalTo: themLabel.centerXAnchor)
        ])

    }
    
    @objc func deleteTheCompanion() {
        deleteCompanion.backgroundColor = resources.red
        deleteCompanion.setTitleColor(resources.lightRed, for: .normal)
        deleteCompanion.setTitle("DELETED", for: .normal)
        
        delegate.deleteCompanion(companion: companion)
    }
    
}
