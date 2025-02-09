//
//  AddHabitViewButtonsActionsDelegate.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/8/25.
//

import Foundation

protocol AddHabitViewButtonsActionsDelegate: AnyObject {
    func saveButtonDidTapped(_ addHabitView: AddHabitView, habitTitle: String)
    func cancelButtonDidTapped(_ addHabitView: AddHabitView)
    func addReminderButtonTapped(_ addHabitView: AddHabitView, date: String?)
}
