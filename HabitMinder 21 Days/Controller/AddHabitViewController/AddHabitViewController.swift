//
//  AddHabitViewController.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/9/24.
//

import UIKit

final class AddHabitViewController: UIViewController {
    
    private let addHabitView = AddHabitView()
    private let notificationAuthorizer = NotificationAuthorizer()
    private(set) var addHabitDataManagement = AddHabitDataManagement()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddHabitView()
    }
    
    private func setupAddHabitView() {
        view.addSubview(addHabitView)
        addHabitView.addHabitViewButtonsActionsDelegate = self
        addHabitView.reminderSwitchActionDelegate = self
        addHabitView.reminderTableViewDelegate = self
        addHabitView.pinToSafeArea()
    }
    
    func checkNotificationAuthorization() {
        notificationAuthorizer.checkNotificationAuthorization { authorized in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                if authorized {
                    self.addHabitView.updateUIForNotificationsAuthorization(isAuthorized: true)
                } else {
                    self.notificationAuthorizer.promptForNotificationAuthorization(in: self)
                    self.addHabitView.updateUIForNotificationsAuthorization(isAuthorized: false)
                }
            }
        }
    }
}
