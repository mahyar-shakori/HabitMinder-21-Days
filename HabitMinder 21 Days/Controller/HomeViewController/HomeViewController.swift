//
//  HomeViewController.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/8/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    private(set) var homeDataManagement = HomeDataManagement()
    var passedQuote: String?
    var coordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHomeView()
        addForegroundEntryObserver()
        setupQuoteLabelTextAndAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        habitTableViewLoadValues()
        checkEmptyView()
    }
    
    private func addHomeView() {
        view.addSubview(homeView)
        
        homeView.homeViewButtonActionDelegate = self
        homeView.habitTableViewDelegate = self
        homeView.futureHabitTableViewDelegate = self
        homeView.dropDownSelectionDelegate = self
        homeView.homeViewDeleteCellDelegate = self
        homeView.pinToSafeArea()
    }
    
    private func addForegroundEntryObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppEnteredForeground), name:  UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func handleAppEnteredForeground() {
        homeView.reloadHabitTableView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupQuoteLabelTextAndAnimation() {
        if let result = passedQuote?.isNotEmpty, result {
            DispatchQueue.delay(0.1) { [weak self] in
                self?.homeView.quoteLabelText = self?.passedQuote
                self?.homeView.typingAnimation()
            }
        }
    }
    
    private func habitTableViewLoadValues() {
        homeDataManagement.fetchHabits()
        homeView.reloadHabitTableView()
    }
    
    func toggleHabitViews() {
        homeDataManagement.fetchFutureHabits()
        homeView.toggleHabitAndFutureHabitViews(isHidden: homeDataManagement.getHabitList().isNotEmpty)
    }
    
    func handleHabitListEditing() {
        if homeDataManagement.getHabitList().isEmpty {
            let okAction = createAlertAction(title: LocalizedStrings.Shared.okButton, style: .default, handler: nil)
            showAlert(title: LocalizedStrings.Alert.Habit.listEmptyTitle, message: "", actions: [okAction])
        } else {
            homeView.toggleEditingMode()
        }
    }
    
    func checkEmptyView() {
        homeView.setEmptyView(isHidden: homeDataManagement.getHabitList().isNotEmpty)
    }
}
