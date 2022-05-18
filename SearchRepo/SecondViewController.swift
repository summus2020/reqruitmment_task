//
//  SecondViewController.swift
//  Recriutment Task
//
//  Created by Oleksandr Artiukh on 17.05.22.
//  Copyright © 2022 Oleksandr Artiukh. All rights reserved.
//

import Foundation
import UIKit

public protocol SecondViewControllerDelegate: class {
    func navigateToFirstPage()
}

class SecondViewController: UIViewController {
    
    public weak var delegate:SecondViewControllerDelegate?
    var repo:Repo!
    
    lazy var avatarImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor.clear
        imgView.layer.masksToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var but_online:UIButton = {
        let but = UIButton(type: UIButton.ButtonType.system)
        but.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        //but.titleLabel?.text = "VIEW ONLINE"
        but.setTitle("VIEW ONLINE", for: .normal)
        but.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        but.layer.cornerRadius = 19
        but.clipsToBounds = true
        but.translatesAutoresizingMaskIntoConstraints = false
        return but
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(avatarImageView)
        avatarImageView.downloaded(from: repo.avatarLink, contentMode: .scaleAspectFill)
        
        view.addSubview(but_online)
        but_online.addTarget(self, action: #selector(on_but_online_clicked), for: UIControl.Event.touchDown)
        
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController!.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navigateToFirstPage))
    }
    
    func setupConstraints(){
        let h = view.frame.size.height/3
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: h),
            
            but_online.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            but_online.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            but_online.widthAnchor.constraint(equalToConstant: 130),
            but_online.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    @objc func navigateToFirstPage(){
        self.delegate?.navigateToFirstPage()
    }
    
    // Button "View Online" clicked
    @objc func on_but_online_clicked(){
        // animate background color
        UIView.animate(withDuration: 0.25, animations: {
            self.but_online.backgroundColor = UIColor.lightGray
        }) { (complete) in
            UIView.animate(withDuration: 0.25, animations: {
                self.but_online.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            }, completion: { (complete) in
                print("button pressed")
            })
        }
    }
}
