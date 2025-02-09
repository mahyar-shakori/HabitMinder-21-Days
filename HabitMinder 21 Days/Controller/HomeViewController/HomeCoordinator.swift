//
//  HomeCoordinator.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/20/25.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(withQuote quote: String = "") {
        let homeVC = HomeViewController()
        homeVC.coordinator = self
        homeVC.passedQuote = quote
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    func navigateToSetNamePage() {
        let setNameCoordinator = SetNameCoordinator(navigationController: navigationController)
        setNameCoordinator.start()
    }
    
    func navigateToAddHabitPage() {
        let addHabitCoordinator = AddHabitCoordinator(navigationController: navigationController)
        addHabitCoordinator.start()
    }
    
    func navigateToEditHabitPage(withHabit selectedHabit: Habit? = nil) {
        let editHabitCoordinator = EditHabitCoordinator(navigationController: navigationController)
        editHabitCoordinator.start(withHabit: selectedHabit)
    }
}
