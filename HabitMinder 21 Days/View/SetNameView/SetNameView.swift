//
//  SetNameView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/7/24.
//

import UIKit

final class SetNameView: UIView {
    
    private weak var hiDialogTopConstraint: NSLayoutConstraint?
    weak var setNameViewButtonActionDelegate: SetNameViewButtonActionDelegate?
    
    private lazy var setNameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = .setNameImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var hiDialogLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.SetNamePage.hiDialogLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .rooneySansBold.withSize(21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userNameView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.accentColor.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = LocalizedStrings.SetNamePage.userNamePlaceholder
        textField.textContentType = .givenName
        textField.textColor = .label
        textField.font = .rooneySansRegular.withSize(16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.SetNamePage.continueButton, for: .normal)
        button.titleLabel?.font = .rooneySansBold.withSize(20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .secondaryColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.SetNamePage.errorLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .rooneySansRegular.withSize(15)
        label.textColor = .red
        label.isHidden = true
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
        userNameView.setCornerRadius(to: userNameView.bounds.height / 2)
        continueButton.setCornerRadius(to: continueButton.bounds.height / 2)
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        [setNameImageView, hiDialogLabel, userNameView, userNameTextField, continueButton, errorLabel].forEach(addSubview)
        userNameTextField.delegate = self
        setupConstraints()
        handleKeyboardDismiss()
    }
    
    private func setupConstraints() {
        setupSetNameImageViewConstraints()
        setupHiDialogLabelConstraints()
        setupUserNameViewConstraints()
        setupUserNameTextFieldConstraints()
        setupContinueButtonConstraints()
        setupErrorLabelConstraints()
    }
    
    @objc private func continueButtonTapped() {
        if let text = userNameTextField.text, text.isEmpty {
            errorLabel.isHidden = false
            userNameView.layer.borderWidth = 2
            userNameView.layer.borderColor = UIColor.red.cgColor
        } else {
            setNameViewButtonActionDelegate?.continueButtonDidTapped(self, userName: userNameTextField.text ?? "")
        }
    }
    
    private func handleKeyboardDismiss() {
        addKeyboardDismissTapGesture()
        addDoneButtonToKeyboard(for: userNameTextField)
    }
    
    private func setupSetNameImageViewConstraints() {
        NSLayoutConstraint.activate([
            setNameImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            setNameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setNameImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setNameImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func setupHiDialogLabelConstraints() {
        let constraints = [
            hiDialogLabel.topAnchor.constraint(equalTo: setNameImageView.bottomAnchor, constant: 64),
            hiDialogLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32)
        ]
        NSLayoutConstraint.activate(constraints)
        hiDialogTopConstraint = constraints[0]
    }
    
    private func setupUserNameViewConstraints() {
        NSLayoutConstraint.activate([
            userNameView.topAnchor.constraint(equalTo: hiDialogLabel.bottomAnchor, constant: 32),
            userNameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            userNameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            userNameView.heightAnchor.constraint(equalTo: userNameView.widthAnchor, multiplier: 0.15)
        ])
    }
    
    
    private func setupUserNameTextFieldConstraints() {
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: userNameView.topAnchor),
            userNameTextField.leadingAnchor.constraint(equalTo: userNameView.leadingAnchor, constant: 8),
            userNameTextField.trailingAnchor.constraint(equalTo: userNameView.trailingAnchor, constant: -8),
            userNameTextField.bottomAnchor.constraint(equalTo: userNameView.bottomAnchor)
        ])
    }
    
    
    private func setupContinueButtonConstraints() {
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: userNameView.bottomAnchor, constant: 88),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            continueButton.heightAnchor.constraint(equalTo: continueButton.widthAnchor, multiplier: 0.15)
        ])
    }
    
    private func setupErrorLabelConstraints() {
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: userNameView.bottomAnchor, constant: 8),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
    
    private func adjustHiDialogConstraint(editing: Bool) {
        hiDialogTopConstraint?.constant = editing ? (16 - setNameImageView.bounds.height) : 64
        setNameImageView.isHidden = editing
    }
}

extension SetNameView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == userNameTextField {
            adjustHiDialogConstraint(editing: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == userNameTextField {
            adjustHiDialogConstraint(editing: false)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == userNameTextField {
            let updatedText = (textField.text as NSString? ?? "").replacingCharacters(in: range, with: string)
            
            userNameView.layer.borderColor = UIColor.accentColor.cgColor
            userNameView.layer.borderWidth = 1
            errorLabel.isHidden = true
            
            continueButton.backgroundColor = updatedText.isEmpty ? .secondaryColor : .accentColor
        }
        return true
    }
}
