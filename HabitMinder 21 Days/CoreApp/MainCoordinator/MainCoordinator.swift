//
//  MainCoordinator.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/7/24.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginStorage = UserDefaultsStorage<UserDefaultKeys, Bool>(key: UserDefaultKeys.isLogin)
        loginStorage.fetch() == true ? showWelcomFlow() : showIntroFlow()
    }
    
    private func showIntroFlow() {
        let introCoordinator = IntroCoordinator(navigationController: navigationController)
        introCoordinator.start()
    }
    
    private func showWelcomFlow() {
        let welcomeCoordinator = WelcomeCoordinator(navigationController: navigationController)
        welcomeCoordinator.start()
    }
}
