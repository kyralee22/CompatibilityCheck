//
//  EnneaDescriptionsViewController.swift
//  compatibility
//
//  Created by Kyra Lee on 1/29/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class EnneaDescriptionsViewController: UIViewController {
    
    var descriptions: [EnneagramDescriptions]!
    let resources: Resources = Resources()
    var associations: [UIButton: EnneagramDescriptions] = [UIButton: EnneagramDescriptions]()
    
    var instructions: UILabel!
    var numbers: [UIButton]!
    var nicknames: [UILabel]!

    init(){
        super.init(nibName: nil, bundle: nil)
        descriptions = []
        fillDescriptions()
        numbers = []
        fillNumbers()
        nicknames = []
        fillNicknames()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup nav bar
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = resources.headerFont.withSize(23)
        titleLabel.textAlignment = .center
        titleLabel.text = "ENNEAGRAM DESCRIPTIONS"
        titleLabel.textColor = resources.red
        
        self.navigationItem.titleView = titleLabel
        
        view.backgroundColor = .white
        
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        instructions = UILabel()
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.text = "click number to learn more"
        instructions.textColor = .black
        instructions.font = resources.numbersFont.withSize(20)
        instructions.textAlignment = .center
        view.addSubview(instructions)
        
        for num in numbers {
            view.addSubview(num)
        }
        
        for nick in nicknames {
            view.addSubview(nick)
        }
    }
    
    func setUpConstraints() {
        let buttonHeight = 80
        var xPos = view.frame.size.width
//        let yThird = (view.frame.size.height - 30) / 3
//        let yTwoThird = (2*(view.frame.size.height - 30)) / 3
        
        NSLayoutConstraint.activate([
            instructions.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            instructions.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        for num in 0..<numbers.count {
            let ennea = descriptions[num].enneagram
            
            if (ennea == "1") || (ennea == "3") || (ennea == "5") || (ennea == "7") {
                xPos = (view.frame.size.width / 6) + 30
            }
            if (ennea == "2") || (ennea == "4") || (ennea == "6") || (ennea == "8") {
                xPos = ((5*view.frame.size.width) / 6) - 30
            }
            if (ennea == "9") {
                xPos = (view.frame.size.width) / 2
            }
            
            if (ennea == "1") || (ennea == "2") {
                NSLayoutConstraint.activate([
                    numbers[num].heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)),
                    numbers[num].widthAnchor.constraint(equalToConstant: CGFloat(50)),
                    numbers[num].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: xPos),
                    numbers[num].topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 20)
                ])
            }
            
            if (ennea == "3") || (ennea == "4") {
                NSLayoutConstraint.activate([
                    numbers[num].heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)),
                    numbers[num].widthAnchor.constraint(equalToConstant: CGFloat(50)),
                    numbers[num].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: xPos),
                    numbers[num].topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 150)
                ])
            }
            
            if (ennea == "5") || (ennea == "6") {
                NSLayoutConstraint.activate([
                    numbers[num].heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)),
                    numbers[num].widthAnchor.constraint(equalToConstant: CGFloat(50)),
                    numbers[num].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: xPos),
                    numbers[num].topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 300)
                ])
            }
            
            if (ennea == "7") || (ennea == "8") {
                NSLayoutConstraint.activate([
                    numbers[num].heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)),
                    numbers[num].widthAnchor.constraint(equalToConstant: CGFloat(50)),
                    numbers[num].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: xPos),
                    numbers[num].topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 450)
                ])
            }
            
            if (ennea == "9") {
                NSLayoutConstraint.activate([
                    numbers[num].heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)),
                    numbers[num].widthAnchor.constraint(equalToConstant: CGFloat(50)),
                    numbers[num].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: xPos),
                    numbers[num].topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 600)
                ])
            }
        }
        
        for nick in 0..<nicknames.count {
            let assocButton = numbers[nick]
            print("constraining \(nicknames[nick])")
            NSLayoutConstraint.activate([
                nicknames[nick].centerXAnchor.constraint(equalTo: assocButton.centerXAnchor),
                nicknames[nick].topAnchor.constraint(equalTo: assocButton.bottomAnchor, constant: 6)
            ])
        }
    }
    
    func fillDescriptions() {
        let dict = csvRead().getEnneaDescript()
        for key in dict.keys {
            let type = key
            let temp = dict[key]
            let obj = EnneagramDescriptions(enneagram: type, nickname: (temp?["Nickname"])!, overall: (temp?["Description"])!, fear: (temp?["Basic Fear"])!, desire: (temp?["Basic Desire"])!, motive: (temp?["Key Motivation"])!)
            descriptions.append(obj)
        }
    }
    
    func fillNumbers() {
        for each in descriptions {
            let temp = UIButton(type: .custom)
            temp.setImage(UIImage(named: each.enneagram), for: .normal)
            temp.translatesAutoresizingMaskIntoConstraints = false
            temp.addTarget(self, action: #selector(clickNumber(_ :)), for: .touchUpInside)
            numbers.append(temp)
            associations[temp] = each
        }
    }
    
    func fillNicknames() {
        for each in descriptions {
            let temp = UILabel()
            var size = 25
            temp.translatesAutoresizingMaskIntoConstraints = false
            temp.text = "\(each.nickname ?? "")".quoted
            let nick = (each.nickname).lowercased()
            if (nick == "the individualist") || (nick == "the investigator") {
                size = 20
            }
            if (nick == "the enthusiast") || (nick == "the challenger") {
                size = 22
            }
            temp.font = resources.headerFont.withSize(CGFloat(size))
            temp.textColor = .gray
            temp.textAlignment = .center
            nicknames.append(temp)
        }
    }
    
    @objc func clickNumber(_ sender: UIButton) {
        let mvc = EnneaModalViewController(ennea: associations[sender] ?? descriptions[0])
        present(mvc, animated: true, completion: nil)
    }
}
