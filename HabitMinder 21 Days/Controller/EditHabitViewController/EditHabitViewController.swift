//
//  EditHabitViewController.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/24/24.
//

import UIKit

final class EditHabitViewController: UIViewController {
    
    private let editHabitView = EditHabitView()
    private(set) var realmDataService = RealmDataService()
    weak var passedHabit: Habit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addEditHabitView()
    }
    
    private func addEditHabitView() {
        view.addSubview(editHabitView)
        editHabitView.editHabitViewButtonsActionsDelegate = self
        editHabitView.pinToSafeArea()
        editHabitView.editHabitTextFieldText = passedHabit?.title
    }
}
