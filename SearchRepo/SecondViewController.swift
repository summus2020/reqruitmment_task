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
    var person:Person!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
    }
    
    func navigateToFirstPage(){
        self.delegate?.navigateToFirstPage()
    }
}
