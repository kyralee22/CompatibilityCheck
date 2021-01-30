//
//  ProfileViewController.swift
//  compatibility
//
//  Created by Kyra Lee on 1/25/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

protocol setHoroscope: class {
    func getHoroscope(horoscope: String)
}

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var isYou: Bool!
    var picBottomY: CGFloat!
    var resources: Resources = Resources()
    weak var delegate: newPerson!
    
    var pic: UIImageView!
    var addPic: UIButton!
    var name: UILabel!
    var nameResponse: UITextField!
    var horoscope: UILabel!
    var horoResponse: UITextField!
    var myersbriggs: UILabel!
    var myersResponse: UITextField!
    var enneagram: UILabel!
    var enneaResponse: [UIButton] = []
    
    var nameText: String!
    var horoText: String!
    var myersText: String!
    var pfp: UIImage!
    
    var companion: Companion?
    var idkHoro: UIButton!
    var idkMBTI: UIButton!
    var idkEnnea: UIButton!
    
    init(isYou: Bool, delegate: newPerson, nameText: String, horoText: String, myersText: String, pfp: UIImage){
        
        self.isYou = isYou
        self.delegate = delegate
        self.nameText = nameText
        self.horoText = horoText
        self.myersText = myersText
        self.pfp = pfp
        
        super.init(nibName: nil, bundle: nil)
        
        pic = UIImageView(image: pfp)
        pic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pic)
        
        NSLayoutConstraint.activate([
            pic.heightAnchor.constraint(equalToConstant: 90),
            pic.widthAnchor.constraint(equalToConstant: 90),
            pic.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15)
        ])
        pic.makeRounded()
        
        setUpViews()
        setUpConstraints()
    }
    
    func setCompanion(comp: Companion) {
        self.companion = comp
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup nav bar
        view.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = resources.headerFont.withSize(30)
        titleLabel.textAlignment = .center
        
        self.navigationItem.titleView = titleLabel
        
        if isYou{
            titleLabel.text = "CREATE PROFILE"
            titleLabel.textColor = resources.purple
        } else {
            titleLabel.text = "NEW COMPANION"
            titleLabel.textColor = resources.yellow
        }
        
        // create save button
        let saveItem = UIBarButtonItem()
        saveItem.title = "SAVE"
        saveItem.setTitleTextAttributes([NSAttributedString.Key.font: resources.headerFont!.withSize(20), NSAttributedString.Key.foregroundColor: UIColor.blue], for: .normal)
        saveItem.action = #selector(saveButton)
        saveItem.target = self
        navigationItem.rightBarButtonItem = saveItem
        
        for i in 1..<10{
            let temp = UIButton()
            temp.setTitle("\(i )", for: .normal)
            temp.setTitleColor(.black, for: .normal)
            temp.backgroundColor = .white
            temp.titleLabel?.baselineAdjustment = .alignCenters
            temp.translatesAutoresizingMaskIntoConstraints = false
            temp.addTarget(self, action: #selector(chooseEnneagram(_:)), for: .touchUpInside)
            temp.layer.borderWidth = 2
            temp.layer.borderColor = resources.seagreen.cgColor
            temp.setTitleColor(UIColor(red: 0.64, green: 0.96, blue: 0.91, alpha: 1.00), for: .normal)
            temp.titleLabel?.font = UIFont(name: "07x5", size: 13.0)
            view.addSubview(temp)
            enneaResponse.append(temp)
        }
    }
    
    @objc func clearField(_ sender: UITextField) {
        if nameResponse.text == ""{
            nameResponse.text = nameText
        }
        if horoResponse.text == ""{
            horoResponse.text = horoText
        }
        if myersResponse.text == ""{
            myersResponse.text = myersText
        }
        sender.text = ""
    }
    
    func setUpViews(){
        
        addPic = UIButton()
        addPic.translatesAutoresizingMaskIntoConstraints = false
        addPic.setTitle("add photo", for: .normal)
        addPic.setTitleColor(.blue, for: .normal)
        addPic.titleLabel?.font = resources.responseFont
        addPic.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        view.addSubview(addPic)
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "NAME"
        name.font = resources.headerFont.withSize(25)
        name.textColor = resources.blue
        view.addSubview(name)
        
        nameResponse = UITextField()
        nameResponse.translatesAutoresizingMaskIntoConstraints = false
        nameResponse.text = nameText
        nameResponse.textAlignment = .center
        nameResponse.layer.borderColor = resources.blue.cgColor
        nameResponse.layer.borderWidth = 3
        nameResponse.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        nameResponse.font = resources.responseFont
        nameResponse.textColor = resources.darkBlue
        nameResponse.addTarget(self, action: #selector(clearField(_:)), for: UIControl.Event.editingDidBegin)
        nameResponse.tag = 0
       // nameResponse.delegate = self
        view.addSubview(nameResponse)
        
        horoscope = UILabel()
        horoscope.translatesAutoresizingMaskIntoConstraints = false
        horoscope.text = "HOROSCOPE"
        horoscope.font = resources.headerFont.withSize(25)
        horoscope.textColor = resources.red
        view.addSubview(horoscope)
        
        horoResponse = UITextField()
        horoResponse.translatesAutoresizingMaskIntoConstraints = false
        horoResponse.text = horoText
        horoResponse.textAlignment = .center
        horoResponse.layer.borderColor = resources.red.cgColor
        horoResponse.layer.borderWidth = 3
        horoResponse.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        horoResponse.font = resources.responseFont
        horoResponse.textColor = resources.lightRed
        horoResponse.addTarget(self, action: #selector(clearField(_:)), for: UIControl.Event.editingDidBegin)
        horoResponse.tag = 1
        view.addSubview(horoResponse)
        
        myersbriggs = UILabel()
        myersbriggs.translatesAutoresizingMaskIntoConstraints = false
        myersbriggs.text = "MYERS-BRIGGS"
        myersbriggs.font = resources.headerFont.withSize(25)
        myersbriggs.textColor = resources.yellow
        view.addSubview(myersbriggs)
        
        myersResponse = UITextField()
        myersResponse.translatesAutoresizingMaskIntoConstraints = false
        myersResponse.text = myersText
        myersResponse.textAlignment = .center
        myersResponse.layer.borderColor = resources.yellow.cgColor
        myersResponse.layer.borderWidth = 3
        myersResponse.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        myersResponse.font = resources.responseFont.withSize(40)
        myersResponse.textColor = resources.darkYellow
        myersResponse.addTarget(self, action: #selector(clearField(_:)), for: UIControl.Event.editingDidBegin)
        myersResponse.tag = 2
        view.addSubview(myersResponse)
        
        enneagram = UILabel()
        enneagram.translatesAutoresizingMaskIntoConstraints = false
        enneagram.text = "ENNEAGRAM"
        enneagram.font = resources.headerFont.withSize(25)
        enneagram.textColor = resources.seagreen
        view.addSubview(enneagram)
        
        idkHoro = UIButton()
        idkHoro.translatesAutoresizingMaskIntoConstraints = false
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: resources.numbersFont.withSize(17),
            .foregroundColor: UIColor.gray,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
        var attributeString = NSMutableAttributedString(string: "don't know?",
                                                           attributes: yourAttributes)
        idkHoro.setAttributedTitle(attributeString, for: .normal)
        idkHoro.setTitleColor(.gray, for: .normal)
        idkHoro.titleLabel?.textAlignment = .center
        idkHoro.addTarget(self, action: #selector(findHoro), for: .touchUpInside)
        view.addSubview(idkHoro)
        
        idkMBTI = UIButton()
        idkMBTI.translatesAutoresizingMaskIntoConstraints = false
        attributeString = NSMutableAttributedString(string: "read MBTI descriptions",
                                                           attributes: yourAttributes)
        idkMBTI.setAttributedTitle(attributeString, for: .normal)
        idkMBTI.setTitleColor(.gray, for: .normal)
        idkMBTI.titleLabel?.textAlignment = .center
        idkMBTI.addTarget(self, action: #selector(findMBTI), for: .touchUpInside)
        view.addSubview(idkMBTI)
        
        idkEnnea = UIButton()
        idkEnnea.translatesAutoresizingMaskIntoConstraints = false
        attributeString = NSMutableAttributedString(string: "read enneagram descriptions",
                                                           attributes: yourAttributes)
        idkEnnea.setAttributedTitle(attributeString, for: .normal)
        idkEnnea.setTitleColor(.gray, for: .normal)
        idkEnnea.titleLabel?.textAlignment = .center
        idkEnnea.addTarget(self, action: #selector(findEnnea), for: .touchUpInside)
        view.addSubview(idkEnnea)
    }
    
    func setUpConstraints() {
        let enneagramWidth = UILabel.textWidth(font: resources.responseFont, text: enneagram.text!)
        let myersWidth = myersbriggs.intrinsicContentSize.width
        let responseWidth = (view.frame.size.width - myersWidth) - 25
        let buttonWidth = responseWidth / 9
        
        NSLayoutConstraint.activate([
            addPic.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            addPic.topAnchor.constraint(equalTo: pic.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameResponse.heightAnchor.constraint(equalToConstant: 50),
            nameResponse.topAnchor.constraint(equalTo: addPic.bottomAnchor, constant: 20),
            nameResponse.widthAnchor.constraint(equalToConstant: responseWidth),
            nameResponse.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
            
        NSLayoutConstraint.activate([
            name.centerYAnchor.constraint(equalTo: nameResponse.centerYAnchor),
            name.trailingAnchor.constraint(equalTo: nameResponse.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            horoResponse.heightAnchor.constraint(equalToConstant: 50),
            horoResponse.topAnchor.constraint(equalTo: nameResponse.bottomAnchor, constant: 10),
            horoResponse.widthAnchor.constraint(equalToConstant: responseWidth),
            horoResponse.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            idkHoro.centerXAnchor.constraint(equalTo: horoResponse.centerXAnchor),
            idkHoro.topAnchor.constraint(lessThanOrEqualTo: horoResponse.bottomAnchor, constant: -2)
        ])
        
        NSLayoutConstraint.activate([
            horoscope.centerYAnchor.constraint(equalTo: horoResponse.centerYAnchor),
            horoscope.trailingAnchor.constraint(equalTo: horoResponse.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            myersResponse.heightAnchor.constraint(equalToConstant: 50),
            myersResponse.topAnchor.constraint(equalTo: horoResponse.bottomAnchor, constant: 25),
            myersResponse.widthAnchor.constraint(equalToConstant: responseWidth),
            myersResponse.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            idkMBTI.centerXAnchor.constraint(equalTo: myersResponse.centerXAnchor),
            idkMBTI.topAnchor.constraint(equalTo: myersResponse.bottomAnchor, constant: -2)
        ])
        
        NSLayoutConstraint.activate([
            myersbriggs.centerYAnchor.constraint(equalTo: myersResponse.centerYAnchor),
            myersbriggs.trailingAnchor.constraint(equalTo: myersResponse.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            enneaResponse[8].widthAnchor.constraint(equalToConstant: buttonWidth),
            enneaResponse[8].heightAnchor.constraint(equalToConstant: buttonWidth),
            enneaResponse[8].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            enneaResponse[8].topAnchor.constraint(equalTo: myersResponse.bottomAnchor, constant: 25)
        ])
        
        for index in stride(from: 7, through: 0, by: -1){
            NSLayoutConstraint.activate([
                enneaResponse[index].widthAnchor.constraint(equalToConstant: buttonWidth),
                enneaResponse[index].heightAnchor.constraint(equalToConstant: buttonWidth),
                enneaResponse[index].centerYAnchor.constraint(equalTo: enneaResponse[index+1].centerYAnchor),
                enneaResponse[index].trailingAnchor.constraint(equalTo: enneaResponse[index+1].leadingAnchor)
            ])
        }
        
        NSLayoutConstraint.activate([
            enneagram.centerYAnchor.constraint(equalTo: enneaResponse[0].centerYAnchor),
            enneagram.trailingAnchor.constraint(equalTo: enneaResponse[0].leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            idkEnnea.centerXAnchor.constraint(equalTo: myersResponse.centerXAnchor),
            idkEnnea.topAnchor.constraint(equalTo: enneaResponse[0].bottomAnchor, constant: -2)
        ])
        
    }
    
    func setDefault(text: String, defaultVal: String) -> String {
        if (text == "") || (text == "their horoscope") || (text == "their personality type"){
            return defaultVal
        }
        return text
    }
   
    @objc func saveButton() {
        var enneaNum: String!
        let theName = nameResponse.text
        var theHoro = (horoResponse.text ?? "zodiac sign").lowercased().trimmingCharacters(in: .
        whitespacesAndNewlines)
        var theMyers = (myersResponse.text ?? "personality type").lowercased().trimmingCharacters(in: .
        whitespacesAndNewlines)
        
        theHoro = setDefault(text: theHoro, defaultVal: "zodiac sign")
        theMyers = setDefault(text: theMyers, defaultVal: "personality type")
        
        for i in 0..<9{
            if enneaResponse[i].backgroundColor == resources.seagreen{
                enneaNum = "\(i+1)"
            }
        }
        let theEnnea = enneaNum ?? "0"
        
        if isYou{
            let createYou = You(pic: pic.image ?? UIImage(named: "noPFP")!, name: theName ?? "name", horoscope: theHoro, myersbriggs: theMyers, enneagram: theEnnea)
            delegate.getYou(you: createYou)
        } else {
            let createCompanion = Companion(pic: pic.image ?? UIImage(named: "noPFP")!, name: "\(theName ?? "their full name")", horoscope: theHoro, myersbriggs: theMyers, enneagram: theEnnea, doDelete: false)
            delegate.getCompanion(companion: createCompanion)
            
            companion = createCompanion
        }
        
        delegate.getPic(image: pic.image ?? UIImage(named: "noPFP")!)
    }
    
    @objc func findHoro() {
        let newMVC = HoroModalViewController(delegate: self)
        present(newMVC, animated: true, completion: nil)
    }
    
    @objc func findMBTI() {
        navigationController?.pushViewController(MBTIDescriptionViewController(), animated: true)
    }
    
    @objc func findEnnea() {
        navigationController?.pushViewController(EnneaDescriptionsViewController(), animated: true)
    }
    
    @objc func addPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func chooseEnneagram(_ sender: UIButton) {
        for i in 0..<9{
            if enneaResponse[i].backgroundColor == resources.seagreen {
                enneaResponse[i].backgroundColor = .white
            }
        }
        
        if sender.backgroundColor == .white{
            sender.backgroundColor = resources.seagreen
        } else {
            sender.backgroundColor = .white
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        dismiss(animated: true)
        
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
       // picName = fileUrl.lastPathComponent
        
        pic.image = image
    }
    
}

extension UILabel {
    func textWidth() -> CGFloat {
        return UILabel.textWidth(label: self)
    }
    
    class func textWidth(label: UILabel) -> CGFloat {
        return textWidth(label: label, text: label.text!)
    }
    
    class func textWidth(label: UILabel, text: String) -> CGFloat {
        return textWidth(font: label.font, text: text)
    }
    
    class func textWidth(font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString
        
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(labelSize.width)
    }
}

extension ProfileViewController: setHoroscope {
    func getHoroscope(horoscope: String) {
        horoResponse.text = horoscope
        horoResponse.isUserInteractionEnabled = false
    }
}
