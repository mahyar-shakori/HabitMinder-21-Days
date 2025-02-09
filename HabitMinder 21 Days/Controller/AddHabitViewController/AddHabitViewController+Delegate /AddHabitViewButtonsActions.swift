//
//  AddHabitViewButtonsActions.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/8/25.
//

import Foundation

extension AddHabitViewController: AddHabitViewButtonsActionsDelegate {
    func saveButtonDidTapped(_ addHabitView: AddHabitView, habitTitle: String) {
        addHabitDataManagement.createHabitWithTitle(habitTitle)
        addHabitDataManagement.saveRemindersForHabit(habitTitle: habitTitle)
        addHabitDataManagement.clearReminders()
        navigationController?.popViewController(animated: true)
    }
    
    func cancelButtonDidTapped(_ addHabitView: AddHabitView) {
        navigationController?.popViewController(animated: true)
    }
    
    func addReminderButtonTapped(_ addHabitView: AddHabitView, date: String?) {
        guard let date = date, date.isNotEmpty else {
            let okAction = createAlertAction(title: LocalizedStrings.Shared.okButton, style: .default, handler: nil)
            showAlert(title: LocalizedStrings.Alert.Date.textFieldEmptyTitle, message: "", actions: [okAction])
            return
        }
        addHabitDataManagement.addReminder(date: date)
    }
}
