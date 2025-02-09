//
//  HomeViewDeleteCellDelegate.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/7/25.
//

import Foundation

protocol HomeViewDeleteCellDelegate: AnyObject {
    func presentDeleteConfirmation(forHabitAt indexPath: IndexPath, tableViewType: TableViewType, confirmDeletion: @escaping (Bool) -> Void)
    func deleteCell(at indexPath: IndexPath, tableViewType: TableViewType)
}
