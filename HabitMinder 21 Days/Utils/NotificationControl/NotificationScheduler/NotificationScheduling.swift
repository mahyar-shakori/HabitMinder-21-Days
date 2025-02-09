//
//  NotificationScheduling.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/14/25.
//

import Foundation

protocol NotificationScheduling {
    func scheduleNotification(identifier: String, title: String, message: String, at date: Date, repeats: Bool)
    func cancelNotification(identifier: String)
}
