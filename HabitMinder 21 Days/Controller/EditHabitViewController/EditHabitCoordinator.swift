//
//  EditHabitCoordinator.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/20/25.
//

import UIKit

final class EditHabitCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private var habit: Habit?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(withHabit selectedHabit: Habit? = nil) {
        let editHabitVC = EditHabitViewController()
        editHabitVC.passedHabit = selectedHabit
        navigationController.pushViewController(editHabitVC, animated: true)
    }
}
