//
//  HomeViewDeleteCell.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/7/25.
//

import Foundation

extension HomeViewController: HomeViewDeleteCellDelegate {
    func presentDeleteConfirmation(forHabitAt indexPath: IndexPath, tableViewType: TableViewType, confirmDeletion: @escaping (Bool) -> Void) {
        let habitTitle = tableViewType == .habit ? homeDataManagement.getHabitList()[indexPath.row].title : homeDataManagement.getFutureHabitList()[indexPath.row].title
        
        let okAction = createAlertAction(title: LocalizedStrings.Shared.okButton, style: .destructive) { [weak self] _ in
            self?.deleteCell(at: indexPath, tableViewType: tableViewType)
            confirmDeletion(true)
        }
        let cancelAction = createAlertAction(title: LocalizedStrings.Shared.cancelButton, style: .cancel) { _ in
            confirmDeletion(false)
        }
        showAlert(title: LocalizedStrings.Alert.Habit.deleteTitle, message: LocalizedStrings.Alert.Habit.deleteMessage + habitTitle + LocalizedStrings.Alert.QustionMark, actions: [okAction, cancelAction])
    }
    
    func deleteCell(at indexPath: IndexPath, tableViewType: TableViewType) {
        switch tableViewType {
        case .habit:
            let habitToDelete = homeDataManagement.getHabitList()[indexPath.row]
            homeDataManagement.removeHabit(habit: habitToDelete, at: indexPath.row)
            checkEmptyView()
            
        case .futureHabit:
            let futureHabitToDelete = homeDataManagement.getFutureHabitList()[indexPath.row]
            homeDataManagement.removeFutureHabit(futureHabit: futureHabitToDelete, at: indexPath.row)
        }
    }
}
