//
//  HabitTableView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/7/25.
//

import Foundation

extension HomeViewController: HabitTableViewDelegate {
    func getHabitList() -> Array<Any> {
        homeDataManagement.getHabitList()
    }
    
    func editHabit(at indexPath: IndexPath) {
        let habit = homeDataManagement.getHabitList()[indexPath.row]
        coordinator?.navigateToEditHabitPage(withHabit: habit)
    }
    
    func reorderHabits(from sourceIndex: IndexPath, to destinationIndex: IndexPath) {
        homeDataManagement.reorderHabits(from: sourceIndex, to: destinationIndex)
    }
}
