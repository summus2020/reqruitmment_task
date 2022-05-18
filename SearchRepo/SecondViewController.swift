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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(avatarImageView)
        avatarImageView.downloaded(from: repo.avatarLink, contentMode: .scaleAspectFill)
        
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
            avatarImageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: h)
        ])
    }
    
    @objc func navigateToFirstPage(){
        self.delegate?.navigateToFirstPage()
    }
}
