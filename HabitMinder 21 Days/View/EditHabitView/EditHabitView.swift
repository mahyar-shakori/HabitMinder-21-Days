//
//  EditHabitView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/24/24.
//

import UIKit

final class EditHabitView: UIView {
    
    weak var editHabitViewButtonsActionsDelegate: EditHabitViewButtonsActionsDelegate?
    private weak var missHabitButtonTopConstraint: NSLayoutConstraint?
    private let halfScreenHeight = UIScreen.main.bounds.height / 2
    
    var editHabitTextFieldText: String? {
        willSet {
            editHabitTextField.text = newValue
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.EditHabitPage.titleLabel
        label.font = .rooneySansBold.withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.Shared.saveButton, for: .normal)
        button.setTitleColor(.accentColor, for: .normal)
        button.titleLabel?.font = .rooneySansBold.withSize(16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.Shared.cancelButton, for: .normal)
        button.setTitleColor(.accentColor, for: .normal)
        button.titleLabel?.font = .rooneySansRegular.withSize(16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var editHabitView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var editHabitTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholderColor = .lightGray
        textField.font = .rooneySansRegular.withSize(17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var missHabitToastLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.EditHabitPage.missHabitToastLabel
        label.font = .rooneySansBold.withSize(20)
        label.textAlignment = .center
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var missHabitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.EditHabitPage.missHabitButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .accentColor
        button.titleLabel?.font = .rooneySansBold.withSize(18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(missHabitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        editHabitView.setCornerRadius(to: editHabitView.bounds.height / 2)
        missHabitToastLabel.setCornerRadius(to: missHabitToastLabel.bounds.height / 4)
        missHabitButton.setCornerRadius(to: missHabitButton.bounds.height / 2)
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        [titleLabel, saveButton, cancelButton, editHabitView, editHabitTextField, missHabitToastLabel, missHabitButton].forEach(addSubview)
        editHabitTextField.delegate = self
        setupConstraints()
        handleKeyboardDismiss()
    }
    
    private func setupConstraints() {
        setupTitleLabelConstraints()
        setupSaveButtonConstraints()
        setupCancelButtonConstraints()
        setupEditHabitViewConstraints()
        setupEditHabitTextFieldConstraints()
        setupMissHabitToastLabelConstraints()
        setupMissHabitButtonConstraints()
    }
    
    @objc private func saveButtonTapped() {
        if let result = editHabitTextField.text?.isEmpty, result {
            saveButton.isEnabled = false
        } else {
            editHabitViewButtonsActionsDelegate?.saveButtonDidTapped(self, editHabitTextFieldText: editHabitTextField.text ?? "")
        }
    }
    
    @objc private func cancelButtonTapped() {
        editHabitViewButtonsActionsDelegate?.cancelButtonDidTapped(self)
    }
    
    @objc private func missHabitButtonTapped() {
        missHabitButton.isEnabled = false
        missHabitButton.backgroundColor = .secondaryColor
        showToast(with: missHabitToastLabel, showDuration: 0.5, showDelay: 0, hideDuration: 0.01, hideDelay: 1)
        editHabitViewButtonsActionsDelegate?.missHabitButtonDidTapped(self)
    }
    
    private func handleKeyboardDismiss() {
        addKeyboardDismissTapGesture()
        addDoneButtonToKeyboard(for: editHabitTextField)
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupSaveButtonConstraints() {
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            saveButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
    
    private func setupCancelButtonConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            cancelButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
    
    private func setupEditHabitViewConstraints() {
        NSLayoutConstraint.activate([
            editHabitView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
            editHabitView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            editHabitView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            editHabitView.heightAnchor.constraint(equalTo: editHabitView.widthAnchor, multiplier: 0.15)
        ])
    }
    
    private func setupEditHabitTextFieldConstraints() {
        NSLayoutConstraint.activate([
            editHabitTextField.topAnchor.constraint(equalTo: editHabitView.topAnchor),
            editHabitTextField.leadingAnchor.constraint(equalTo: editHabitView.leadingAnchor, constant: 16),
            editHabitTextField.trailingAnchor.constraint(equalTo: editHabitView.trailingAnchor, constant: -16),
            editHabitTextField.bottomAnchor.constraint(equalTo: editHabitView.bottomAnchor)
        ])
    }
    
    private func setupMissHabitToastLabelConstraints() {
        NSLayoutConstraint.activate([
            missHabitToastLabel.topAnchor.constraint(equalTo: editHabitView.bottomAnchor, constant: 32),
            missHabitToastLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupMissHabitButtonConstraints() {
        let constraints = [
            missHabitButton.topAnchor.constraint(equalTo: editHabitView.bottomAnchor, constant: halfScreenHeight),
            missHabitButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            missHabitButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            missHabitButton.heightAnchor.constraint(equalTo: missHabitButton.widthAnchor, multiplier: 0.15)
        ]
        NSLayoutConstraint.activate(constraints)
        missHabitButtonTopConstraint = constraints[0]
    }
    
    private func adjustHiDialogConstraint(editing: Bool) {
        missHabitButtonTopConstraint?.constant = editing ? 80 : halfScreenHeight
    }
}

extension EditHabitView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == editHabitTextField {
            adjustHiDialogConstraint(editing: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == editHabitTextField {
            adjustHiDialogConstraint(editing: false)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == editHabitTextField {
            let updatedText = (textField.text as NSString? ?? "").replacingCharacters(in: range, with: string)
            
            if updatedText.isEmpty {
                saveButton.isEnabled = false
                saveButton.setTitleColor(.secondaryColor, for: .normal)
            } else {
                saveButton.isEnabled = true
                saveButton.setTitleColor(.accentColor, for: .normal)
            }
        }
        return true
    }
}
