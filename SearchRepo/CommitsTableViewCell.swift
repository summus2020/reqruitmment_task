//
//  CommitsTableViewCell.swift
//  SearchRepo
//
//  Created by Oleksandr Artiukh on 19.05.22.
//  Copyright © 2022 Oleksandr Artiukh. All rights reserved.
//

import Foundation
import UIKit

class CommitsTableViewCell: UITableViewCell {
    
    let indxHeight:CGFloat = 40
    
    var lbl_num:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var lbl_name:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.init(red: 35/255, green: 134/255, blue: 252/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var lbl_email:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var lbl_description:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.gray
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textAlignment = .left
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        lbl_num.layer.cornerRadius = indxHeight/2
        lbl_num.clipsToBounds = true;
        addSubview(lbl_num)
        addSubview(lbl_name)
        addSubview(lbl_email)
        addSubview(lbl_description)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(indx:Int, name:String, email:String, descr:String){
        lbl_num.text = String(indx)
        lbl_name.text = name
        lbl_name.sizeToFit()
        lbl_email.text = email
        lbl_email.sizeToFit()
        lbl_description.text = descr
        lbl_description.sizeToFit()
        
        setupConstrants()
    }
    
    func setupConstrants(){
        NSLayoutConstraint.activate([
            lbl_num.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            lbl_num.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            lbl_num.widthAnchor.constraint(equalToConstant: indxHeight),
            lbl_num.heightAnchor.constraint(equalToConstant: indxHeight),
            
            lbl_name.leftAnchor.constraint(equalTo: lbl_num.rightAnchor, constant: 18),
            lbl_name.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            lbl_name.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            lbl_email.leftAnchor.constraint(equalTo: lbl_num.rightAnchor, constant: 18),
            lbl_email.topAnchor.constraint(equalTo: lbl_name.bottomAnchor, constant: 3),
            lbl_email.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            lbl_email.heightAnchor.constraint(equalToConstant: 20),
            
            lbl_description.leftAnchor.constraint(equalTo: lbl_num.rightAnchor, constant: 18),
            lbl_description.topAnchor.constraint(equalTo: lbl_email.bottomAnchor, constant: 2),
            lbl_description.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            lbl_description.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
            
        ])
    }
}
