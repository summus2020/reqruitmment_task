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
    
    lazy var repoImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor.clear
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        view.addSubview(repoImageView)
        //repoImageView.downloaded(from: <#T##String#>)
        
        
    }
    
    func estupConstraints(){
        
    }
    
    func navigateToFirstPage(){
        self.delegate?.navigateToFirstPage()
    }
}
