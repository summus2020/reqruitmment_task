//
//  SearchTableViewCell.swift
//  Recriutment Task
//
//  Created by Oleksandr Artiukh on 18.05.22.
//  Copyright © 2022 Oleksandr Artiukh. All rights reserved.
//

import Foundation
import UIKit

struct Person {
    var imageLink:String = ""
    var name:String = ""
    var num_commits:Int = 0
    
}

class SearchTableViewCell: UITableViewCell {
    
    lazy var personImage: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor.clear
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var nameLabel:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .left
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var starImgView:UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var commitLabel:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.gray
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
        layer.cornerRadius = 8
        clipsToBounds = true
        accessoryType = .disclosureIndicator
        
        //add imageView
        personImage.layer.cornerRadius = 8
        personImage.clipsToBounds = true
        addSubview(personImage)
        
        //add name label
        addSubview(nameLabel)
        // add star image
        starImgView.image = UIImage(named: "star")
        addSubview(starImgView)
        // add number of commits label
        addSubview(commitLabel)
        
        setupConstrains()
    }
    
    func setupConstrains(){
        NSLayoutConstraint.activate([
            personImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            personImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            personImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            personImage.widthAnchor.constraint(equalTo: personImage.heightAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: personImage.rightAnchor, constant: 18),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            
            starImgView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0),
            starImgView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            starImgView.widthAnchor.constraint(equalToConstant: 14),
            starImgView.heightAnchor.constraint(equalToConstant: 14),
            
            commitLabel.leftAnchor.constraint(equalTo: starImgView.rightAnchor, constant: 6),
            //commitLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            commitLabel.centerYAnchor.constraint(equalTo: starImgView.centerYAnchor, constant: 1),
            commitLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor)
            
        ])
    }
    
    func setupCell(image: String, name:String, commits:Int) {
        personImage.downloaded(from: image)
        nameLabel.text = name
        commitLabel.text = String(commits)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
