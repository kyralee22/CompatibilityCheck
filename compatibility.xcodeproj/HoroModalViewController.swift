//
//  HoroModalViewController.swift
//  compatibility
//
//  Created by Kyra Lee on 1/28/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class HoroModalViewController: UIViewController {
    
    weak var delegate: setHoroscope!
    var resources: Resources = Resources()
    var zodiac: String?
    var saveButton: UIButton!
    
    var birthday: UILabel!
    var monthLabel: UILabel!
    var dayLabel: UILabel!
    var monthResponse: UITextField!
    var dayResponse: UITextField!
    
    var enterButton: UIButton!
    var bornOn: UILabel!
    var date: UILabel?
    var zodiacSign: UILabel?
    var zodiacPic: UIImageView?
    
    init(delegate: setHoroscope?){
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.setTitleColor(.blue, for: .normal)
        saveButton.titleLabel?.font = resources.headerFont.withSize(20)
        saveButton.titleLabel?.textAlignment = .right
        saveButton.addTarget(self, action: #selector(saveZodiac), for: .touchUpInside)
        view.addSubview(saveButton)
        
        birthday = UILabel()
        birthday.translatesAutoresizingMaskIntoConstraints = false
        birthday.text = "BIRTHDAY"
        birthday.font = resources.headerFont.withSize(40)
        birthday.textColor = resources.yellow
        view.addSubview(birthday)
        
        monthLabel = UILabel()
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.text = "MONTH"
        monthLabel.font = resources.headerFont.withSize(30)
        monthLabel.textColor = resources.darkPurple
        view.addSubview(monthLabel)
        
        monthResponse = UITextField()
        monthResponse.translatesAutoresizingMaskIntoConstraints = false
        monthResponse.textAlignment = .center
        monthResponse.layer.borderColor = resources.darkPurple.cgColor
        monthResponse.layer.borderWidth = 3
        monthResponse.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        monthResponse.font = resources.responseFont
        monthResponse.textColor = resources.purple
        view.addSubview(monthResponse)
        
        dayLabel = UILabel()
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.text = "DAY"
        dayLabel.font = resources.headerFont.withSize(30)
        dayLabel.textColor = resources.darkPurple
        view.addSubview(dayLabel)
        
        dayResponse = UITextField()
        dayResponse.translatesAutoresizingMaskIntoConstraints = false
        dayResponse.textAlignment = .center
        dayResponse.layer.borderColor = resources.darkPurple.cgColor
        dayResponse.layer.borderWidth = 3
        dayResponse.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        dayResponse.font = resources.responseFont
        dayResponse.textColor = resources.purple
        view.addSubview(dayResponse)
        
        enterButton = UIButton()
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: resources.headerFont.withSize(25),
            .foregroundColor: resources.blue,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: "ENTER",
                                                           attributes: yourAttributes)
        enterButton.setAttributedTitle(attributeString, for: .normal)
        enterButton.setTitleColor(resources.blue, for: .normal)
        enterButton.addTarget(self, action: #selector(enterBday), for: .touchUpInside)
        enterButton.titleLabel?.textAlignment = .center
        view.addSubview(enterButton)
        
        bornOn = UILabel()
        bornOn.translatesAutoresizingMaskIntoConstraints = false
        bornOn.text = "BORN ON"
        bornOn.font = resources.numbersFont.withSize(30)
        bornOn.textAlignment = .center
        bornOn.textColor = .gray
        view.addSubview(bornOn)
    }
    
    func setUpConstraints() {
        let boxWidth = (view.frame.size.width - 10) / 2
        let boxHeight: CGFloat = 70.0
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            birthday.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            birthday.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
        
        NSLayoutConstraint.activate([
            monthResponse.widthAnchor.constraint(equalToConstant: boxWidth),
            monthResponse.heightAnchor.constraint(equalToConstant: boxHeight),
            monthResponse.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            monthResponse.topAnchor.constraint(equalTo: birthday.bottomAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            dayResponse.widthAnchor.constraint(equalToConstant: boxWidth),
            dayResponse.heightAnchor.constraint(equalToConstant: boxHeight),
            dayResponse.leadingAnchor.constraint(equalTo: monthResponse.trailingAnchor),
            dayResponse.topAnchor.constraint(equalTo: birthday.bottomAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            monthLabel.centerXAnchor.constraint(equalTo: monthResponse.centerXAnchor),
            monthLabel.bottomAnchor.constraint(equalTo: monthResponse.topAnchor, constant: -2)
        ])
        
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: dayResponse.centerXAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: dayResponse.topAnchor, constant: -2)
        ])
        
        NSLayoutConstraint.activate([
            enterButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            enterButton.topAnchor.constraint(equalTo: monthResponse.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            bornOn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            bornOn.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func saveZodiac() {
        delegate.getHoroscope(horoscope: zodiac ?? "zodiac sign")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func enterBday() {
        // calc zodiac
        // make date, zodiacSign, zodiacPic
        calcZodiac()
        
        date = UILabel()
        date?.translatesAutoresizingMaskIntoConstraints = false
        date?.text = "\(shortenMonth()) \(dayResponse.text!)"
        date?.font = resources.numbersFont.withSize(30)
        date?.textColor = resources.red
        date?.textAlignment = .center
        view.addSubview(date!)
        
        NSLayoutConstraint.activate([
            date!.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            date!.topAnchor.constraint(equalTo: bornOn.bottomAnchor, constant: 5)
        ])
        
        zodiacSign = UILabel()
        zodiacSign?.translatesAutoresizingMaskIntoConstraints = false
        zodiacSign?.text = zodiac?.uppercased()
        zodiacSign?.textColor = resources.seagreen
        zodiacSign?.font = resources.headerFont
        zodiacSign?.textAlignment = .center
        view.addSubview(zodiacSign!)
        
        NSLayoutConstraint.activate([
            zodiacSign!.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            zodiacSign!.topAnchor.constraint(equalTo: date!.bottomAnchor, constant: 10)
        ])
        
        zodiacPic = UIImageView(image: UIImage(named: zodiac!))
        zodiacPic?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(zodiacPic!)
        
        NSLayoutConstraint.activate([
            zodiacPic!.widthAnchor.constraint(equalToConstant: 70),
            zodiacPic!.heightAnchor.constraint(equalToConstant: 70),
            zodiacPic!.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            zodiacPic!.topAnchor.constraint(equalTo: zodiacSign!.bottomAnchor, constant: 5)
        ])
    }
    
    func shortenMonth() -> String {
        if monthResponse.text!.count >= 4 {
            return "\((monthResponse.text![0..<3]).uppercased())."
        }
        return (monthResponse.text!).uppercased()
    }
    
    func calcZodiac() {
        let month = (monthResponse.text?.lowercased())!.trimmingCharacters(in: .
        whitespacesAndNewlines)
        let day = Int(dayResponse.text ?? "1")
        
        if (month == "january") || (month == "jan") {
            if (day! >= 21) {
                zodiac = "aquarius"
            } else {
                zodiac = "capricorn"
            }
        }
        
        if (month == "february") || (month == "feb") {
            if (day! >= 20) {
                zodiac = "pisces"
            } else {
                zodiac = "aquarius"
            }
        }
        
        if (month == "march") || (month == "mar") {
            if (day! >= 21) {
                zodiac = "aries"
            } else {
                zodiac = "pisces"
            }
        }
        
        if (month == "april") || (month == "apr") {
            if (day! >= 21) {
                zodiac = "taurus"
            } else {
                zodiac = "aries"
            }
        }
        
        if (month == "may") {
            if (day! >= 22) {
                zodiac = "gemini"
            } else {
                zodiac = "taurus"
            }
        }
        
        if (month == "june") {
            if (day! >= 22) {
                zodiac = "cancer"
            } else {
                zodiac = "gemini"
            }
        }
        
        if (month == "july") {
            if (day! >= 23) {
                zodiac = "leo"
            } else {
                zodiac = "cancer"
            }
        }
        
        if (month == "august") || (month == "aug") {
            if (day! >= 24) {
                zodiac = "virgo"
            } else {
                zodiac = "leo"
            }
        }
        
        if (month == "september") || (month == "sept") {
            if (day! >= 24) {
                zodiac = "libra"
            } else {
                zodiac = "virgo"
            }
        }
        
        if (month == "october") || (month == "oct") {
            if (day! >= 24) {
                zodiac = "scorpio"
            } else {
                zodiac = "libra"
            }
        }
        
        if (month == "november") || (month == "nov") {
            if (day! >= 23) {
                zodiac = "sagittarius"
            } else {
                zodiac = "scorpio"
            }
        }
        
        if (month == "december") || (month == "sept") {
            if (day! >= 22) {
                zodiac = "capricorn"
            } else {
                zodiac = "sagittarius"
            }
        }
    }
}
