//
//  ReminderTableViewDelegate.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/8/25.
//

import Foundation

protocol ReminderTableViewDelegate: AnyObject {
    func getReminderList() -> Array<Any>
    func presentDeleteConfirmation(forReminderAt indexPath: IndexPath, confirmDeletion: @escaping (Bool) -> Void)
    func deleteReminder(at indexPath: IndexPath)
}
