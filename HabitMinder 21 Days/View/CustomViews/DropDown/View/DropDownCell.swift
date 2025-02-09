//
//  DropDownCell.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/9/24.
//

import UIKit

final class DropDownCell: UITableViewCell {
        
    private lazy var dropDownCellView: DropDownCellView = {
        let view = DropDownCellView()
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
        contentView.addSubview(dropDownCellView)
        dropDownCellView.pinToSafeArea()
    }
    
    func configure(title: String, image: UIImage?) {
        dropDownCellView.titleLabelText = title
        dropDownCellView.iconImageViewImage = image
    }
}
