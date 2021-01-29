//
//  MBTIDescriptionViewController.swift
//  compatibility
//
//  Created by Kyra Lee on 1/29/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class MBTIDescriptionViewController: UIViewController {
    
    let resources: Resources = Resources()
    let descriptionID: String = "MBTI Descriptions"
    var instructions: UILabel!
    var descriptions: [MBTIDescriptions]!
    var tableView: UITableView!
    
    init(){
        super.init(nibName: nil, bundle: nil)
        descriptions = []
        fillCompanions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup nav bar
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = resources.headerFont.withSize(25)
        titleLabel.textAlignment = .center
        titleLabel.text = "MBTI DESCRIPTIONS"
        titleLabel.textColor = resources.purple
        
        self.navigationItem.titleView = titleLabel
        
        view.backgroundColor = .white
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        instructions = UILabel()
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.text = "click on the box to learn more"
        instructions.font = resources.numbersFont.withSize(20)
        instructions.textAlignment = .center
        instructions.textColor = .black
        view.addSubview(instructions)
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MBTIDescriptionTableViewCell.self, forCellReuseIdentifier: descriptionID)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func setUpConstraints() {
        let tvWidth = view.frame.size.width - 10
        let tvHeight = view.frame.size.height - 30
        
        NSLayoutConstraint.activate([
            instructions.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            instructions.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalToConstant: tvWidth),
            tableView.heightAnchor.constraint(equalToConstant: tvHeight),
            tableView.topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 10),
            tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    func fillCompanions() {
        let myersDescript = csvRead().getMyersDescript()
        var temp: MBTIDescriptions!
        
        for key in myersDescript.keys {
            let pick = myersDescript[key]
            let nickname = pick?["Nickname"]
            let description = pick?["Description"]
            temp = MBTIDescriptions(type: key, nickname: nickname!, description: description!)
            descriptions.append(temp!)
        }
    }

}

extension MBTIDescriptionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // tableView.deselectRow(at: indexPath, animated: true)
        print("pushed cell")
        let newMVC = MBTIModalViewController(MBTI: descriptions[indexPath.row])
        present(newMVC, animated: true, completion: nil)
    }

}

extension MBTIDescriptionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < descriptions.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: descriptionID, for: indexPath) as! MBTIDescriptionTableViewCell
            let description = descriptions[indexPath.row]
            cell.configure(MBTI: description)
            cell.layer.borderWidth = 3
            cell.layer.borderColor = UIColor.black.cgColor
            cell.backgroundColor = .white
            cell.clipsToBounds = true
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

