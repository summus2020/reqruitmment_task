//
//  SearchTableViewCell.swift
//  Recriutment Task
//
//  Created by Oleksandr Artiukh on 18.05.22.
//  Copyright © 2022 Oleksandr Artiukh. All rights reserved.
//

import Foundation
import UIKit


class SearchTableViewCell: UITableViewCell {
    
    lazy var repoAvatar: UIImageView = {
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
        repoAvatar.layer.cornerRadius = 8
        repoAvatar.clipsToBounds = true
        addSubview(repoAvatar)
        
        //add name label
        addSubview(nameLabel)
        // add star image
        starImgView.image = UIImage(named: "star")
        addSubview(starImgView)
        // add number of commits label
        addSubview(commitLabel)
        
        setupConstrains()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = self.frame.inset(by: UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0))
    }
    
    func setupConstrains(){
        NSLayoutConstraint.activate([
            repoAvatar.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            repoAvatar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            repoAvatar.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            repoAvatar.widthAnchor.constraint(equalTo: repoAvatar.heightAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: repoAvatar.rightAnchor, constant: 18),
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
    
    func setupCell(image: String, name:String, stars:Int) {
        repoAvatar.downloaded(from: image)
        nameLabel.text = name
        commitLabel.text = String(stars)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
