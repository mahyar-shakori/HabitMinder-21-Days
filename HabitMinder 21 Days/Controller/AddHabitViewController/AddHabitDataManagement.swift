//
//  AddHabitDataManagement.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/8/25.
//

import UIKit

final class AddHabitDataManagement {
    
    private var reminderList = [Reminder]()
    private var habit = Habit()
    private let realmDataService = RealmDataService()
    
    func getReminderList() -> [Reminder] {
        reminderList
    }
    
    func addReminder(date: String) {
        let reminder = Reminder()
        reminder.reminderTime = date
        reminder.id = realmDataService.incrementID(for: Reminder.self)
        reminderList.append(reminder)
        habit.reminders.append(reminder)
        realmDataService.addObject(reminder)
    }
    
    func deleteReminder(reminder: Reminder, at index: Int) {
        realmDataService.deleteObject(reminder)
        reminderList.remove(at: index)
    }
    
    func createHabitWithTitle(_ title: String) {
        habit.title = title
        habit.id = realmDataService.incrementID(for: Habit.self)
        realmDataService.addObject(habit)
    }
    
    func saveRemindersForHabit(habitTitle: String) {
        for reminder in reminderList {
            let notificationIdentifier = "\(reminder.id)"
            let title = LocalizedStrings.AddHabitPage.reminderLabel
            let message = LocalizedStrings.Notification.message + habitTitle
            let dateString = reminder.reminderTime
            let date = DateFormatter.date(from: dateString, format: .timeOnly) ?? Date()
            
            NotificationScheduler.shared.scheduleNotification(identifier: notificationIdentifier, title: title, message: message, at: date)
        }
        reminderList.removeAll()
    }
    
    func clearReminders() {
        reminderList.removeAll()
    }
}
