//
//  DropDownCellView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/12/25.
//

import UIKit

final class DropDownCellView: UIView {
    
    var titleLabelText: String? {
        willSet {
            titleLabel.text = newValue
        }
    }
    
    weak var iconImageViewImage: UIImage? {
        willSet {
            iconImageView.image = newValue
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .rooneySansRegular.withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        backgroundColor = .systemGray6
        [titleLabel, iconImageView].forEach(addSubview)
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupTitleLabelConstraints()
        setupIconImageViewConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupIconImageViewConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            iconImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.06)
        ])
    }
}
