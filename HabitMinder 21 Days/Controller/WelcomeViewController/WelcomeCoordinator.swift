//
//  WelcomeCoordinator.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/20/25.
//

import UIKit

final class WelcomeCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let welcomeVC = WelcomeViewController()
        welcomeVC.coordinator = self
        welcomeVC.quoteDelegate = self
        navigationController.pushViewController(welcomeVC, animated: true)
    }
    
    func navigateToHomePage(withQuote quote: String) {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start(withQuote: quote)
    }
}

extension WelcomeCoordinator: QuoteProtocol {
    func didPassQuote(_ quote: String) {
        navigateToHomePage(withQuote: quote)
    }
}
