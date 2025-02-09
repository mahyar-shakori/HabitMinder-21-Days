//
//  SetNameCoordinator.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/20/25.
//

import UIKit

final class SetNameCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let setNameVC = SetNameViewController()
        setNameVC.coordinator = self
        navigationController.pushViewController(setNameVC, animated: true)
    }
    
    func navigateToWelcomePage() {
        let welcomeCoordinator = WelcomeCoordinator(navigationController: navigationController)
        welcomeCoordinator.start()
    }
}
