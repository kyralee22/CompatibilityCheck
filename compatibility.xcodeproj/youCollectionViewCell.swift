//
//  youCollectionViewCell.swift
//  compatibility
//
//  Created by Kyra Lee on 1/25/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class youCollectionViewCell: UICollectionViewCell {
    
    var name: UILabel!
    var pfp: UIImageView!
    var horoscope: UIImageView!
    var myersbriggs: UIImageView!
    var enneagram: UIImageView!
    
    var individualWidth: CGFloat!
    var halfWidth: CGFloat!
    var picHeight: CGFloat!
    
    let resources: Resources = Resources()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = resources.lightBlue
        
        individualWidth = contentView.frame.size.width / 4
        halfWidth = individualWidth / 2
        picHeight = contentView.frame.size.height - 20
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textAlignment = .center
        name.font = resources.responseFont.withSize(50)
        name.isUserInteractionEnabled = false
        contentView.addSubview(name)
        
        horoscope = UIImageView()
        horoscope.translatesAutoresizingMaskIntoConstraints = false
        horoscope.contentMode = .scaleAspectFit
        horoscope.clipsToBounds = true
        contentView.addSubview(horoscope)
        
        myersbriggs = UIImageView()
        myersbriggs.translatesAutoresizingMaskIntoConstraints = false
        myersbriggs.contentMode = .scaleAspectFit
        myersbriggs.clipsToBounds = true
        contentView.addSubview(myersbriggs)
        
        enneagram = UIImageView()
        enneagram.translatesAutoresizingMaskIntoConstraints = false
        enneagram.contentMode = .scaleAspectFit
        enneagram.clipsToBounds = true
        contentView.addSubview(enneagram)
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            horoscope.heightAnchor.constraint(equalToConstant: picHeight),
            horoscope.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            horoscope.centerXAnchor.constraint(equalTo: pfp.centerXAnchor, constant: individualWidth)
        ])
        
        NSLayoutConstraint.activate([
            myersbriggs.heightAnchor.constraint(equalToConstant: picHeight),
            myersbriggs.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            myersbriggs.centerXAnchor.constraint(equalTo: horoscope.centerXAnchor, constant: individualWidth)
        ])
        
        NSLayoutConstraint.activate([
            enneagram.heightAnchor.constraint(equalToConstant: picHeight),
            enneagram.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            enneagram.centerXAnchor.constraint(equalTo: myersbriggs.centerXAnchor, constant: individualWidth)
        ])
    }
    
    func configure(name: String, horoscope: String, myersbriggs: String, enneagram: String, image: UIImage){
        self.horoscope.image = UIImage(named: horoscope)
        self.myersbriggs.image = UIImage(named: myersbriggs)
        self.enneagram.image = UIImage(named: enneagram)
        
        pfp = UIImageView(image: image)// UIImage(named: pic))
        pfp.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pfp)
        
        NSLayoutConstraint.activate ([
            pfp.heightAnchor.constraint(equalToConstant: picHeight),
            pfp.widthAnchor.constraint(equalToConstant: picHeight),
            pfp.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: halfWidth),
            pfp.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor)
            ])
        pfp.makeRounded()
        
        if name != "name"{
            self.name.text = name
            self.name.textColor = resources.blue
           // self.name.backgroundColor = resources.blue
            
            NSLayoutConstraint.activate([
                self.name.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                self.name.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor)
            ])
            contentView.bringSubviewToFront(self.name)
        }
        
        setUpConstraints()
    }
}



