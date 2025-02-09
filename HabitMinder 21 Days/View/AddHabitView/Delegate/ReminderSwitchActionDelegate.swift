//
//  ReminderSwitchActionDelegate.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/8/25.
//

import Foundation

protocol ReminderSwitchActionDelegate: AnyObject {
    func reminderSwitchChanged(_ addHabitView: AddHabitView, isOn: Bool)
}
