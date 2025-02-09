//
//  SetNameViewController+Delegate.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/17/25.
//

import Foundation

extension SetNameViewController: SetNameViewButtonActionDelegate {
    func continueButtonDidTapped(_ setNameView: SetNameView, userName: String) {
        let userNameStorage = UserDefaultsStorage<UserDefaultKeys, String>(key: UserDefaultKeys.userName)
        let loginStorage = UserDefaultsStorage<UserDefaultKeys, Bool>(key: UserDefaultKeys.isLogin)

        userNameStorage.save(value: userName)
        loginStorage.save(value: true)
        coordinator?.navigateToWelcomePage()
    }
}
