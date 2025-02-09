//
//  HomeViewButtonActionDelegate.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/26/25.
//

import UIKit

protocol HomeViewButtonActionDelegate: AnyObject {
    func saveButtonDidTapped(_ homeView: HomeView, futureHabitTitle: String)
}
