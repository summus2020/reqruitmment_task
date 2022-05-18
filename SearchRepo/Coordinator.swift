//
//  Coordinator.swift
//  Recriutment Task
//
//  Created by Oleksandr Artiukh on 18.05.22.
//  Copyright © 2022 Oleksandr Artiukh. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    
    var childCoordinators:[Coordinator]{get set}
    init(navigationController:UINavigationController)
    
    func start()
}


class FirstCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    unowned let navigationController:UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let firstViewController: FirstViewController = FirstViewController()
        firstViewController.delegate = self
        self.navigationController.viewControllers = [firstViewController]
    }
    
    
    
}
extension FirstCoordinator:FirstViewControllerDelegate{
    
    func navigateToNextPage(repo:Repo){
        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
        secondCoordinator.delegate = self
        secondCoordinator.repo = repo
        childCoordinators.append(secondCoordinator)
        secondCoordinator.start()
    }
}
extension FirstCoordinator: BackToFirstViewControllerDelegate {
    
    func navigateBackToFirstPage(newOrderCoordinator: SecondCoordinator) {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}

protocol BackToFirstViewControllerDelegate: class {
    
    func navigateBackToFirstPage(newOrderCoordinator: SecondCoordinator)
    
}

class SecondCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var repo:Repo?
    
    unowned let navigationController:UINavigationController
    
    // We use this delegate to keep a reference to the parent coordinator
    weak var delegate: BackToFirstViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let secondViewController : SecondViewController = SecondViewController()
        secondViewController.repo = repo!
        secondViewController.delegate = self
        self.navigationController.pushViewController(secondViewController, animated: true)
    }
}

extension SecondCoordinator: SecondViewControllerDelegate {
    
    // Navigate to first page
    func navigateToFirstPage() {
        self.delegate?.navigateBackToFirstPage(newOrderCoordinator: self)
    }
}
