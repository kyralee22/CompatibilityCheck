//
//  MBTIDescriptionTableViewCell.swift
//  compatibility
//
//  Created by Kyra Lee on 1/29/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class MBTIDescriptionTableViewCell: UITableViewCell {
    
    var MBTI: MBTIDescriptions!
    let resources: Resources = Resources()
    
    var type: UILabel!
    var pic: UIImageView!
    var nickname: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(MBTI: MBTIDescriptions) {
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        self.MBTI = MBTI
        
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        var textSize = 27
        if MBTI.type == "istp" {
            textSize = 24
        } else {
            if MBTI.type == "entj" {
                textSize = 25
            }
        }
        
        type = UILabel()
        type.translatesAutoresizingMaskIntoConstraints = false
        type.text = MBTI.type
        type.font = resources.headerFont.withSize(40)
        type.textColor = MBTI.color
        type.textAlignment = .center
        contentView.addSubview(type)
        
        pic = UIImageView(image: UIImage(named: (MBTI.type).lowercased()))
        pic.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pic)
        
        nickname = UILabel()
        nickname.translatesAutoresizingMaskIntoConstraints = false
        nickname.text = "\(MBTI.nickname ?? "")".quoted
        nickname.font = resources.headerFont.withSize(CGFloat(textSize))
        nickname.textColor = .gray
        nickname.textAlignment = .center
        contentView.addSubview(nickname)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            type.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            type.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pic.widthAnchor.constraint(equalToConstant: 60),
            pic.heightAnchor.constraint(equalToConstant: 60),
            pic.leadingAnchor.constraint(equalTo: type.trailingAnchor),
            pic.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nickname.leadingAnchor.constraint(equalTo: pic.trailingAnchor),
            nickname.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

}

extension String {
    static var quotes: (String, String) {
        guard
            let bQuote = Locale.current.quotationBeginDelimiter,
            let eQuote = Locale.current.quotationEndDelimiter
            else { return ("\"", "\"") }
        
        return (bQuote, eQuote)
    }
    
    var quoted: String {
        let (bQuote, eQuote) = String.quotes
        return bQuote + self + eQuote
    }
}
