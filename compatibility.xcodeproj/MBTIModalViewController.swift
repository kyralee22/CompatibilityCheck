//
//  MBTIModalViewController.swift
//  compatibility
//
//  Created by Kyra Lee on 1/29/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class MBTIModalViewController: UIViewController {

    var resources: Resources = Resources()
    var MBTI: MBTIDescriptions!
    var doneButton: UIButton!
    var pic: UIImageView!
    var type: UILabel!
    var nickname: UILabel!
    var describe: UITextView!
    
    init(MBTI: MBTIDescriptions){
        super.init(nibName: nil, bundle: nil)
        
        self.MBTI = MBTI
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
        doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("DONE", for: .normal)
        doneButton.setTitleColor(.blue, for: .normal)
        doneButton.titleLabel?.font = resources.headerFont.withSize(30)
        doneButton.titleLabel?.textAlignment = .right
        doneButton.addTarget(self, action: #selector(readyToExit), for: .touchUpInside)
        view.addSubview(doneButton)
        
        pic = UIImageView(image: UIImage(named: MBTI.type))
        pic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pic)
        
        type = UILabel()
        type.translatesAutoresizingMaskIntoConstraints = false
        type.text = "\((MBTI.type).uppercased())"
        type.font = resources.headerFont.withSize(30)
        type.textColor = MBTI.color
        type.textAlignment = .center
        view.addSubview(type)
        
        nickname = UILabel()
        nickname.translatesAutoresizingMaskIntoConstraints = false
        nickname.text = "\(MBTI.nickname ?? "")".quoted
        nickname.font = resources.headerFont.withSize(CGFloat(28))
        nickname.textColor = .gray
        nickname.textAlignment = .center
        view.addSubview(nickname)
        
        describe = UITextView()
        describe.translatesAutoresizingMaskIntoConstraints = false
        describe.isScrollEnabled = false
        describe.text = "\(MBTI.description ?? "no description available")"
        describe.textAlignment = .center
       // describe.adjustsFontSizeToFitWidth = true
        describe.isUserInteractionEnabled = false
        describe.font = resources.numbersFont.withSize(30)
        describe.textColor = .black
        view.addSubview(describe)
        
    }
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7)
        ])
        
        NSLayoutConstraint.activate([
            pic.widthAnchor.constraint(equalToConstant: 80),
            pic.heightAnchor.constraint(equalToConstant: 80),
            pic.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pic.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            type.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            type.topAnchor.constraint(equalTo: pic.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            nickname.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nickname.topAnchor.constraint(equalTo: type.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            describe.widthAnchor.constraint(equalToConstant: view.frame.size.width - 20),
            describe.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            describe.topAnchor.constraint(equalTo: nickname.bottomAnchor, constant: 10),
//            describe.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
    @objc func readyToExit() {
        dismiss(animated: true, completion: nil)
    }

}
