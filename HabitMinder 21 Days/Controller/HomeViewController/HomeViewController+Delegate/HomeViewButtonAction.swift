//
//  HomeViewButtonAction.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/7/25.
//

import Foundation

extension HomeViewController: HomeViewButtonActionDelegate {
    func saveButtonDidTapped(_ homeView: HomeView, futureHabitTitle: String) {
        homeDataManagement.addFutureHabit(title: futureHabitTitle)
    }
}
