//
//  HabitCellView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/16/24.
//

import UIKit

final class HabitCellView: UIView {
    
    var titleLabelText: String? {
        willSet {
            titleLabel.text = newValue
        }
    }
    
    var daysCountLabelText: String? {
        willSet {
            daysCountLabel.text = newValue
        }
    }
    
    var daysCountCircularView: Float? {
        willSet {
            daysCountCircular.setProgressWithAnimation(to: newValue ?? 0, duration: 1)
        }
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var daysCountCircular: CircularProgressView = {
        let circularView = CircularProgressView()
        circularView.translatesAutoresizingMaskIntoConstraints = false
        return circularView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .rooneySansBold.withSize(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var daysCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .rooneySansRegular.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.setCornerRadius(to: containerView.bounds.height / 4)
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        [containerView, daysCountCircular, titleLabel, daysCountLabel].forEach(addSubview)
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupContainerViewConstraints()
        setupDaysCountCircularConstraints()
        setupTitleLabelConstraints()
        setupDaysCountLabelConstraints()
    }
    
    private func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4)
        ])
    }
    
    private func setupDaysCountCircularConstraints() {
        NSLayoutConstraint.activate([
            daysCountCircular.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            daysCountCircular.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            daysCountCircular.widthAnchor.constraint(equalTo: daysCountCircular.heightAnchor),
            daysCountCircular.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        let daysCountLabelWidth = daysCountLabel.bounds.width + 48
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: daysCountCircular.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -daysCountLabelWidth),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    private func setupDaysCountLabelConstraints() {
        NSLayoutConstraint.activate([
            daysCountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            daysCountLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}
