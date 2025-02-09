//
//  ReminderTableView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/8/25.
//

import Foundation

extension AddHabitViewController: ReminderTableViewDelegate {
    func getReminderList() -> Array<Any> {
        addHabitDataManagement.getReminderList()
    }
    
    func presentDeleteConfirmation(forReminderAt indexPath: IndexPath, confirmDeletion: @escaping (Bool) -> Void) {
        let reminder = addHabitDataManagement.getReminderList()[indexPath.row]
        
        let okAction = self.createAlertAction(title: LocalizedStrings.Shared.okButton, style: .destructive, handler: {_ in
            confirmDeletion(true)
        })
        let cancelAction = self.createAlertAction(title: LocalizedStrings.Shared.noButton, style: .cancel, handler: { _ in
            confirmDeletion(false)
        })
        
        self.showAlert(title: LocalizedStrings.Alert.Reminder.deleteTitle, message: LocalizedStrings.Alert.Reminder.deleteMessage + reminder.reminderTime + LocalizedStrings.Alert.QustionMark, actions: [okAction, cancelAction])
    }
    
    func deleteReminder(at indexPath: IndexPath) {
        let reminderToDelete = addHabitDataManagement.getReminderList()[indexPath.row]
        addHabitDataManagement.deleteReminder(reminder: reminderToDelete, at: indexPath.row)
    }
}
