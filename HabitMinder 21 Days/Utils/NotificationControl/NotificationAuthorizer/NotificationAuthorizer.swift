//
//  NotificationAuthorizer.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/14/25.
//

import UIKit
import UserNotifications
import os

final class NotificationAuthorizer: NotificationAuthorization {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
            let logger = Logger(subsystem: "com.example.myapp", category: "permissions")
            
            if success {
                logger.notice("User granted permission")
            } else {
                logger.error("User denied permission")
            }
        }
    }
    
    func checkNotificationAuthorization(completion: @escaping (Bool) -> Void) {
        notificationCenter.getNotificationSettings { settings in
            completion(settings.authorizationStatus == .authorized)
        }
    }
    
    func promptForNotificationAuthorization(in viewController: UIViewController) {
        let settingsAction = UIAlertAction(title: LocalizedStrings.Alert.Notification.settingButton, style: .default) { [weak self] _ in
            self?.openAppSettings()
        }
        let cancelAction = UIAlertAction(title: LocalizedStrings.Shared.cancelButton, style: .cancel, handler: nil)
        
        viewController.showAlert(title: LocalizedStrings.Alert.Notification.title, message: LocalizedStrings.Alert.Notification.message, actions: [settingsAction, cancelAction])
    }
    
    private func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
}
