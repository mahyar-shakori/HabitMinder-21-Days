//
//  FutureHabitTableViewDelegate.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/7/25.
//

import Foundation

protocol FutureHabitTableViewDelegate: AnyObject {
    func getFutureHabitList() -> Array<Any>
}
