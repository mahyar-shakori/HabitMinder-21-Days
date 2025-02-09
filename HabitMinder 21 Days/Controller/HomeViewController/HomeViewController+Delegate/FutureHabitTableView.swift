//
//  FutureHabitTableView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/7/25.
//

import Foundation

extension HomeViewController: FutureHabitTableViewDelegate {
    func getFutureHabitList() -> Array<Any> {
        homeDataManagement.getFutureHabitList()
    }
}
