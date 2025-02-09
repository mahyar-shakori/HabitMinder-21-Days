//
//  HabitCell.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/10/24.
//

import UIKit

final class HabitCell: UITableViewCell {
    
    private lazy var habitCellView: HabitCellView = {
        let view = HabitCellView()
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
        contentView.addSubview(habitCellView)
        habitCellView.pinToSafeArea()
    }
    
    func configure(_ habit: Habit) {
        let daysLeft = habit.dateCreate.habitDaysCountSinceCreation(for: habit.id)
        let progress = Float(22 - daysLeft) / 22
        
        habitCellView.titleLabelText = habit.title
        habitCellView.daysCountLabelText = "\(daysLeft)" + LocalizedStrings.Cell.Habit.daysLeft
        habitCellView.daysCountCircularView = progress
    }
}
