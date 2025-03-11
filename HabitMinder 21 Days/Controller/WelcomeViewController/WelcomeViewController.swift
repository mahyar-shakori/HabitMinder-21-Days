//
//  WelcomeViewController.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/7/24.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    private let welcomeView = WelcomeView()
    private let networkAPI: NetworkAPIProtocol
    weak var quoteDelegate: QuoteProtocol?
    var coordinator: WelcomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWelcomeView()
        callGetQuoteAPI()
    }
    
    init(networkAPI: NetworkAPIProtocol = NetworkAPI()) {
            self.networkAPI = networkAPI
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private func addWelcomeView() {
        view.addSubview(welcomeView)
        welcomeView.setIndicatorAnimating(true)
        welcomeView.animateLabel(view: view)
        welcomeView.pinToSafeArea()
        setNameLabelText()
    }
    
    private func setNameLabelText() {
        let nameLabelText: String
        
        let userNameStorage = UserDefaultsStorage<UserDefaultKeys, String>(key: UserDefaultKeys.userName)
        
        if let userName = userNameStorage.fetch() {
            nameLabelText = LocalizedStrings.WelcomePage.welcomeLabel + userName
        } else {
            nameLabelText = LocalizedStrings.WelcomePage.guestLabel
        }
        welcomeView.updateLabel(text: nameLabelText)
    }
    
    private func callGetQuoteAPI() {
        let quoteStorage = UserDefaultsStorage<UserDefaultKeys, Bool>(key: .isQuoteOff)
        
        if let result = quoteStorage.fetch(), result {
            handleQuoteDisabled()
        } else {
            fetchQuote()
        }
    }
    
    private func handleQuoteDisabled() {
        DispatchQueue.delay(1.5) { [weak self] in
            self?.coordinator?.navigateToHomePage(withQuote: "")
        }
    }
    
    private func fetchQuote() {
        Task {
            do {
                let quotes: [QuoteResponse] = try await networkAPI.fetchData(from: AuthEndpoint.getQuote, decodeType: [QuoteResponse].self)
                handleQuoteSuccess(quotes: quotes)
            } catch {
                handleQuoteFailure(error: error)
            }
        }
    }
    
    private func handleQuoteSuccess(quotes: [QuoteResponse]) {
        if let firstQuote = quotes.first {
            let quoteToSend = firstQuote.quote.count > 100 ? LocalizedStrings.WelcomePage.defaultQuote : firstQuote.quote
            DispatchQueue.main.async { [weak self] in
                self?.coordinator?.navigateToHomePage(withQuote: quoteToSend)
            }
        }
    }

    private func handleQuoteFailure(error: Error) {
        DispatchQueue.delay(0.5) { [weak self] in
            self?.showErrorAlert(error: error)
        }
    }
    
    private func showErrorAlert(error: Error) {
        welcomeView.setIndicatorAnimating(false)
        let okAction = createAlertAction(title: LocalizedStrings.Shared.okButton, style: .default) { [weak self] _ in
            self?.coordinator?.navigateToHomePage(withQuote: "")
        }
        showAlert(title: LocalizedStrings.Alert.Network.title, message: error.localizedDescription, actions: [okAction])
    }
}
