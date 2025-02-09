//
//  HabitTableViewDelegate.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/7/25.
//

import Foundation

protocol HabitTableViewDelegate: AnyObject {
    func reorderHabits(from sourceIndex: IndexPath, to destinationIndex: IndexPath)
    func getHabitList() -> Array<Any>
    func editHabit(at indexPath: IndexPath)
}
