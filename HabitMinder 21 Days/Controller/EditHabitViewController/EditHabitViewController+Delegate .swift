//
//  EditHabitViewController+Delegate .swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/25/25.
//

import UIKit

extension EditHabitViewController: EditHabitViewButtonsActionsDelegate {
    
    func saveButtonDidTapped(_ editHabitView: EditHabitView, editHabitTextFieldText: String) {
        guard let habitTitle = passedHabit?.title, editHabitTextFieldText.isNotEmpty else {
            return
        }
        realmDataService.updateHabit(habitTitle: habitTitle, newTitle: editHabitTextFieldText)
        navigationController?.popViewController(animated: true)
    }
    
    func cancelButtonDidTapped(_ editHabitView: EditHabitView) {
        navigationController?.popViewController(animated: true)
    }
    
    func missHabitButtonDidTapped(_ editHabitView: EditHabitView) {
        
        guard let habitTitle = passedHabit?.title else {
            return
        }
        realmDataService.updateHabit(habitTitle: habitTitle, newTitle: habitTitle, updateDateCreate: true)
    }
}
