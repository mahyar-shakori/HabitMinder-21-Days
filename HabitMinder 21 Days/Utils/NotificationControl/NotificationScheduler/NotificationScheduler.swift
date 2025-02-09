//
//  NotificationHandler.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/14/25.
//

import Foundation
import UserNotifications

final class NotificationScheduler: NotificationScheduling {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    private let delegateHandler = NotificationDelegateHandler()
    static let shared = NotificationScheduler()
    
    private init() {
        notificationCenter.delegate = delegateHandler
    }
    
    func scheduleNotification(identifier: String, title: String, message: String, at date: Date, repeats: Bool = true) {
        
        notificationCenter.getNotificationSettings { [weak self] settings in
            if settings.authorizationStatus == .authorized {
                self?.createAndAddNotification(identifier: identifier, title: title, message: message, at: date, repeats: repeats)
            } 
        }
    }
    
    private func createAndAddNotification(identifier: String, title: String, message: String, at date: Date, repeats: Bool) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = .default
        
        let trigger = createTrigger(for: date, repeats: repeats)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.add(request)
    }
    
    private func createTrigger(for date: Date, repeats: Bool) -> UNNotificationTrigger {
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
    }
    
    func cancelNotification(identifier: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
