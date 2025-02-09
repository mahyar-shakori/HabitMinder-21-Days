//
//  IntroViewController+Delegate.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/17/25.
//

import Foundation

extension IntroViewController: IntroViewButtonActionDelegate {
    func introViewDidFinish(_ introView: IntroView) {
        coordinator?.navigateToSetNamePage()
    }
}
