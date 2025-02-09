//
//  IntroView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/18/24.
//

import UIKit

final class IntroView: UIView {
    
    private var currentState: IntroViewState = .first
    weak var introViewButtonActionDelegate: IntroViewButtonActionDelegate?
    
    private lazy var introImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .healtyHabitImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.IntroPage.firstTitleLabel
        label.numberOfLines = 0
        label.font = .rooneySansBold.withSize(24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.IntroPage.firstDescriptionLabel
        label.numberOfLines = 0
        label.font = .rooneySansRegular.withSize(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.IntroPage.skipButton, for: .normal)
        button.titleLabel?.font = .rooneySansRegular.withSize(16)
        button.setTitleColor(.accentColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.IntroPage.nextButton, for: .normal)
        button.titleLabel?.font = .rooneySansBold.withSize(18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .accentColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControlDot: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .pageControlDot1stImage
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nextButton.setCornerRadius(to: nextButton.bounds.height / 2)
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        [introImageView, titleLabel, descriptionLabel, skipButton, nextButton, pageControlDot].forEach(addSubview)
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupIntroImageViewConstraints()
        setupTitleLabelConstraints()
        setupDescriptionLabelConstraints()
        setupSkipButtonConstraints()
        setupNextButtonConstraints()
        setupPageControlDotConstraints()
    }
    
    private func updateViewForSecondState() {
        introImageView.image = .BadHabitImage
        titleLabel.text = LocalizedStrings.IntroPage.secondTitleLabel
        descriptionLabel.text = LocalizedStrings.IntroPage.secondDescriptionLabel
        pageControlDot.image = .pageControlDot2ndImage
        skipButton.isHidden = true
        currentState = .second
    }
    
    @objc private func skipButtonTapped() {
        introViewButtonActionDelegate?.introViewDidFinish(self)
    }
    
    @objc private func nextButtonTapped() {
        switch currentState {
        case .first:
            updateViewForSecondState()
        case .second:
            introViewButtonActionDelegate?.introViewDidFinish(self)
        }
    }
    
    private func setupIntroImageViewConstraints() {
        NSLayoutConstraint.activate([
            introImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 48),
            introImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            introImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            introImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: introImageView.bottomAnchor, constant: -32),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
    }
    
    private func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
    }
    
    private func setupSkipButtonConstraints() {
        NSLayoutConstraint.activate([
            skipButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            skipButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -48),
        ])
    }
    
    private func setupNextButtonConstraints() {
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            nextButton.centerYAnchor.constraint(equalTo: skipButton.centerYAnchor),
            nextButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            nextButton.heightAnchor.constraint(equalTo: nextButton.widthAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupPageControlDotConstraints() {
        NSLayoutConstraint.activate([
            pageControlDot.centerYAnchor.constraint(equalTo: skipButton.centerYAnchor),
            pageControlDot.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
