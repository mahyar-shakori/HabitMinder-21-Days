//
//  NotificationDelegateHandler.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/14/25.
//

import UIKit

final class NotificationDelegateHandler: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
