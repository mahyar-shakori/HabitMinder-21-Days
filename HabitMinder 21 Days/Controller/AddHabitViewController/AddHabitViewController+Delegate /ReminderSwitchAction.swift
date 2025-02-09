//
//  ReminderSwitchAction.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/8/25.
//

import Foundation

extension AddHabitViewController: ReminderSwitchActionDelegate {
    func reminderSwitchChanged(_ addHabitView: AddHabitView, isOn: Bool) {
        if isOn {
            checkNotificationAuthorization()
        } else {
            addHabitDataManagement.clearReminders()
        }
    }
}
