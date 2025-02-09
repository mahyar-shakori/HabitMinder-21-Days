//
//  SeparatorLine.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/14/24.
//

import UIKit

final class SeparatorLine: UIView {
    
    private weak var heightConstraint: NSLayoutConstraint?
    private var lineColor: UIColor
    private var lineHeight: CGFloat
    
    init(lineColor: UIColor = .systemGray5, lineHeight: CGFloat = 1) {
        self.lineHeight = lineHeight
        self.lineColor = lineColor
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
#if DEBUG
        fatalError("init(coder:) has not been implemented")
#else
        super.init(coder: coder)
#endif
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = lineColor
        
        heightConstraint = heightAnchor.constraint(equalToConstant: lineHeight)
        heightConstraint?.isActive = true
    }
}
