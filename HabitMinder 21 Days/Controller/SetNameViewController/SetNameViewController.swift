//
//  SetNameViewController.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/8/24.
//

import UIKit

final class SetNameViewController: UIViewController {
    
    private let setNameView = SetNameView()
    var coordinator: SetNameCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSetNameView()
    }
    
    private func addSetNameView() {
        view.addSubview(setNameView)
        setNameView.setNameViewButtonActionDelegate = self
        setNameView.pinToSafeArea()
    }
}
