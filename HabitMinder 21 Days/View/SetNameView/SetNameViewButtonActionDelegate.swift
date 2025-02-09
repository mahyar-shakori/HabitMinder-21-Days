//
//  SetNameViewButtonActionDelegate.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/17/25.
//

import Foundation

protocol SetNameViewButtonActionDelegate: AnyObject {
    func continueButtonDidTapped(_ setNameView: SetNameView, userName: String)
}
