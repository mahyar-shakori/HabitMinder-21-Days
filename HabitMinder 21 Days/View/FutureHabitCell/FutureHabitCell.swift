//
//  FutureHabitCell.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/4/24.
//

import UIKit

final class FutureHabitCell: UITableViewCell {
    
    private lazy var futureHabitCellView: FutureHabitCellView = {
        let view = FutureHabitCellView()
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
        contentView.addSubview(futureHabitCellView)
        futureHabitCellView.pinToSafeArea()
    }
    
    func configure(_ futureHabit: FutureHabit) {
        futureHabitCellView.titleLabelText = futureHabit.title
    }
}
