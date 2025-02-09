//
//  NotificationAuthorization.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/14/25.
//

import UIKit

protocol NotificationAuthorization {
    func requestAuthorization()
    func checkNotificationAuthorization(completion: @escaping (Bool) -> Void)
    func promptForNotificationAuthorization(in viewController: UIViewController)
}
