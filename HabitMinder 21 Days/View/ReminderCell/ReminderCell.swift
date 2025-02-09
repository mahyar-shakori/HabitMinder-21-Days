//
//  ReminderCell.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/9/24.
//

import UIKit

final class ReminderCell: UITableViewCell {
    
    private lazy var reminderCellView: ReminderCellView = {
        let view = ReminderCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        contentView.addSubview(reminderCellView)
        reminderCellView.pinToSafeArea()
    }
    
    func configure(_ reminder: Reminder) {
        reminderCellView.titleLabelText = reminder.reminderTime
    }
}
