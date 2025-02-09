//
//  WelcomeView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/7/24.
//

import UIKit

final class WelcomeView: UIView {
    
    private lazy var loginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .loginImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .rooneySansBold.withSize(23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .secondaryColor
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        [loginImageView, nameLabel, loadingIndicator].forEach(addSubview)
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupLoginImageViewConstraints()
        setupNameLabelConstraints()
        setupActivityIndicatorConstraints()
    }
    
    func animateLabel(view: UIView) {
        nameLabel.animateToCenter(of: view, duration: 1.5)
    }
    
    func updateLabel(text: String) {
        nameLabel.text = text
    }
    
    func setIndicatorAnimating(_ animate: Bool) {
        animate ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
    }
    
    private func setupLoginImageViewConstraints() {
        NSLayoutConstraint.activate([
            loginImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loginImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginImageView.widthAnchor.constraint(equalTo: loginImageView.heightAnchor),
            loginImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: loginImageView.bottomAnchor, constant: 64),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
