//
//  DropDownSelection.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/7/25.
//

import Foundation

extension HomeViewController: DropDownSelectionDelegate {
    func handleDropDownSelection(index: Int) {
        let quoteStorage = UserDefaultsStorage<UserDefaultKeys, Bool>(key: UserDefaultKeys.isQuoteOff)
        let loginStorage = UserDefaultsStorage<UserDefaultKeys, Bool>(key: UserDefaultKeys.isLogin)
        
        guard let selection = DropDownOption(rawValue: index) else {
            return
        }
        
        switch selection {
        case .addHabit:
            coordinator?.navigateToAddHabitPage()
            
        case .toggleHabitView:
            toggleHabitViews()
            
        case .editHabitList:
            handleHabitListEditing()
            
        case .disableQuote:
            quoteStorage.save(value: true)
            
        case .rename:
            [loginStorage, quoteStorage].forEach { $0.save(value: false) }
            coordinator?.navigateToSetNamePage()
        }
    }
}
