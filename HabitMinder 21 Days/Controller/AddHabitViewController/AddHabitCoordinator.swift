//
//  AddHabitCoordinator.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/20/25.
//

import UIKit

final class AddHabitCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let addHabitVC = AddHabitViewController()
        navigationController.pushViewController(addHabitVC, animated: true)
    }
}
