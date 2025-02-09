//
//  EditHabitViewButtonsActionsDelegate.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/25/25.
//

import Foundation

protocol EditHabitViewButtonsActionsDelegate: AnyObject {
    func saveButtonDidTapped(_ editHabitView: EditHabitView, editHabitTextFieldText: String)
    func cancelButtonDidTapped(_ editHabitView: EditHabitView)
    func missHabitButtonDidTapped(_ editHabitView: EditHabitView)
}
