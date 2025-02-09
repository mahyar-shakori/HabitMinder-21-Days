//
//  IntroViewController.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/18/24.
//

import UIKit

final class IntroViewController: UIViewController {
    
    private let introView = IntroView()
    private var notificationAuthorizer = NotificationAuthorizer()
    
    var coordinator: IntroCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationAuthorizer.requestAuthorization()
        addIntroView()
    }
    
    private func addIntroView() {
        view.addSubview(introView)
        introView.introViewButtonActionDelegate = self
        introView.pinToSafeArea()
    }
}
