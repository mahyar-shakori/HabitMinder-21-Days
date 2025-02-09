//
//  IntroCoordinator.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/20/25.
//

import  UIKit

final class IntroCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let introVC = IntroViewController()
        introVC.coordinator = self
        navigationController.pushViewController(introVC, animated: true)
    }
    
    func navigateToSetNamePage() {
        let setNameCoordinator = SetNameCoordinator(navigationController: navigationController)
        setNameCoordinator.start()
    }
}
