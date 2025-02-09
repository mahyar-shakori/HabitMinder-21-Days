//
//  AddHabitView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/11/24.
//

import UIKit

final class AddHabitView: UIView {
    
    private lazy var firstSeparator = SeparatorLine()
    private lazy var secondSeparator = SeparatorLine()
    weak var addHabitViewButtonsActionsDelegate: AddHabitViewButtonsActionsDelegate?
    weak var reminderSwitchActionDelegate: ReminderSwitchActionDelegate?
    weak var reminderTableViewDelegate: ReminderTableViewDelegate?
    
    private lazy var addHabitTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.AddHabitPage.titleLabel
        label.font = .rooneySansBold.withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.Shared.saveButton, for: .normal)
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
    
    private lazy var addHabitView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addHabitTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = LocalizedStrings.Shared.habitPlaceholder
        textField.placeholderColor = .lightGray
        textField.font = .rooneySansRegular.withSize(17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.setCornerRadius(to: 12.5)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var reminderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var reminderLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.AddHabitPage.reminderLabel
        label.font = .rooneySansRegular.withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var reminderSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(reminderSwitchValueChanged(_:)), for: .valueChanged)
        return switchControl
    }()
    
    private lazy var dateView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.AddHabitPage.dateLabel
        label.font = .rooneySansRegular.withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = .rooneySansRegular.withSize(17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var addReminderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addReminderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.AddHabitPage.addReminderButton, for: .normal)
        button.titleLabel?.font = .rooneySansBold.withSize(17)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addReminderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var reminderTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        addHabitView.setCornerRadius(to: addHabitView.bounds.height / 4)
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        [addHabitTitleLabel, saveButton, cancelButton, addHabitView, addHabitTextField, stackView, firstSeparator, secondSeparator, reminderTableView].forEach(addSubview)
        [reminderView, dateView, addReminderView].forEach(stackView.addArrangedSubview)
        [reminderLabel, reminderSwitch].forEach(reminderView.addSubview)
        [dateLabel, dateTextField].forEach(dateView.addSubview)
        addReminderView.addSubview(addReminderButton)
        addHabitTextField.delegate = self
        setupConstraints()
        datePickerSetup()
        reminderTableViewConfigs()
        handleKeyboardDismiss()
        updateAddHabitView(false)
    }
    
    private func setupConstraints() {
        setupAddHabitTitleLabelConstraints()
        setupSaveButtonConstraints()
        setupCancelButtonConstraints()
        setupAddHabitViewConstraints()
        setupAddHabitTextFieldConstraints()
        setupStackViewConstraints()
        setupReminderViewConstraints()
        setupReminderLabelConstraints()
        setupReminderSwitchConstraints()
        setupFirstSeparatorConstraints()
        setupDateViewConstraints()
        setupDateLabelConstraints()
        setupDateTextFieldConstraints()
        setupSecondSeparatorConstraints()
        setupAddReminderViewConstraints()
        setupAddReminderButtonConstraints()
        setupReminderTableViewConstraints()
    }
    
    @objc private func saveButtonTapped() {
        addHabitViewButtonsActionsDelegate?.saveButtonDidTapped(self, habitTitle: addHabitTextField.text ?? "")
    }
    
    @objc private func cancelButtonTapped() {
        addHabitViewButtonsActionsDelegate?.cancelButtonDidTapped(self)
    }
    
    @objc func reminderSwitchValueChanged(_ sender: UISwitch) {
        reminderSwitchAction(isOn: sender.isOn)
        reminderSwitchActionDelegate?.reminderSwitchChanged(self, isOn: sender.isOn)
        
        guard sender.isOn else {
            reminderTableView.reloadData()
            return
        }
    }
    
    @objc private func addReminderButtonTapped() {
        addHabitViewButtonsActionsDelegate?.addReminderButtonTapped(self, date: dateTextField.text)
        
        if let result = dateTextField.text?.isNotEmpty, result {
            addReminderButton.setTitleColor(.label.withAlphaComponent(0.3), for: .normal)
            dateLabel.isHidden = false
            reminderTableView.reloadData()
            dismissKeyboard()
            dateTextField.text = nil
        }
    }
    
    private func datePickerSetup() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    @objc func dateChanged(_ datePicker: UIDatePicker) {
        let formattedDate = DateFormatter.string(from: datePicker.date, format: .timeOnly)
        dateTextField.text = formattedDate
        dateLabel.isHidden = true
        addReminderButton.setTitleColor(.label.withAlphaComponent(1.0), for: .normal)
    }
    
    private func reminderTableViewConfigs() {
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
        reminderTableView.register(ReminderCell.self, forCellReuseIdentifier: .reminderCellIdentifier)
    }
    
    private func handleKeyboardDismiss() {
        addKeyboardDismissTapGesture()
        addDoneButtonToKeyboard(for: addHabitTextField)
        addDoneButtonToKeyboard(for: dateTextField)
    }
    
    private func updateAddHabitView(_ isHabitEmpty: Bool) {
        saveButton.isEnabled = isHabitEmpty
        reminderSwitch.isEnabled = isHabitEmpty
        
        if isHabitEmpty {
            saveButton.setTitleColor(.accentColor, for: .normal)
        } else {
            saveButton.setTitleColor(.secondaryColor, for: .normal)
            reminderSwitch.isOn = false
            reminderSwitchAction(isOn: false)
            reminderSwitchActionDelegate?.reminderSwitchChanged(self, isOn: false)
            reminderTableView.reloadData()
        }
    }
    
    private func reminderSwitchAction(isOn: Bool) {
        firstSeparator.isVisible = isOn
        dateView.isVisible = isOn
        secondSeparator.isVisible = isOn
        addReminderView.isVisible = isOn
        
        if isOn {
            dateLabel.isHidden = false
        } else {
            dateTextField.text = ""
            addReminderButton.setTitleColor(.label.withAlphaComponent(0.3), for: .normal)
            dateLabel.textColor = .label
        }
    }
    
    func updateUIForNotificationsAuthorization(isAuthorized: Bool) {
        dateTextField.isEnabled = isAuthorized
        dateTextField.isUserInteractionEnabled = isAuthorized
        dateLabel.textColor = isAuthorized ? .label : .label.withAlphaComponent(0.3)
    }
    
    private func setupAddHabitTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            addHabitTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            addHabitTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupSaveButtonConstraints() {
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            saveButton.centerYAnchor.constraint(equalTo: addHabitTitleLabel.centerYAnchor)
        ])
    }
    
    private func setupCancelButtonConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            cancelButton.centerYAnchor.constraint(equalTo: addHabitTitleLabel.centerYAnchor)
        ])
    }
    
    private func setupAddHabitViewConstraints() {
        NSLayoutConstraint.activate([
            addHabitView.topAnchor.constraint(equalTo: addHabitTitleLabel.bottomAnchor, constant: 48),
            addHabitView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addHabitView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            addHabitView.heightAnchor.constraint(equalTo: addHabitView.widthAnchor, multiplier: 0.15)
        ])
    }
    
    private func setupAddHabitTextFieldConstraints() {
        NSLayoutConstraint.activate([
            addHabitTextField.topAnchor.constraint(equalTo: addHabitView.topAnchor),
            addHabitTextField.leadingAnchor.constraint(equalTo: addHabitView.leadingAnchor, constant: 16),
            addHabitTextField.trailingAnchor.constraint(equalTo: addHabitView.trailingAnchor, constant: -16),
            addHabitTextField.bottomAnchor.constraint(equalTo: addHabitView.bottomAnchor)
        ])
    }
    
    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: addHabitView.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupReminderViewConstraints() {
        NSLayoutConstraint.activate([
            reminderView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            reminderView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            reminderView.heightAnchor.constraint(equalTo: reminderView.widthAnchor, multiplier: 0.15)
        ])
    }
    
    private func setupReminderLabelConstraints() {
        NSLayoutConstraint.activate([
            reminderLabel.leadingAnchor.constraint(equalTo: reminderView.leadingAnchor, constant: 16),
            reminderLabel.centerYAnchor.constraint(equalTo: reminderView.centerYAnchor)
        ])
    }
    
    private func setupReminderSwitchConstraints() {
        NSLayoutConstraint.activate([
            reminderSwitch.trailingAnchor.constraint(equalTo: reminderView.trailingAnchor, constant: -16),
            reminderSwitch.centerYAnchor.constraint(equalTo: reminderView.centerYAnchor)
        ])
    }
    
    private func setupFirstSeparatorConstraints() {
        NSLayoutConstraint.activate([
            firstSeparator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            firstSeparator.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            firstSeparator.bottomAnchor.constraint(equalTo: reminderView.bottomAnchor),
        ])
    }
    
    private func setupDateViewConstraints() {
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: firstSeparator.bottomAnchor),
            dateView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            dateView.heightAnchor.constraint(equalTo: dateView.widthAnchor, multiplier: 0.15)
        ])
    }
    
    private func setupDateLabelConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 16),
            dateLabel.centerYAnchor.constraint(equalTo: dateView.centerYAnchor)
        ])
    }
    
    private func setupDateTextFieldConstraints() {
        NSLayoutConstraint.activate([
            dateTextField.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 16),
            dateTextField.trailingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -16),
            dateTextField.centerYAnchor.constraint(equalTo: dateView.centerYAnchor)
        ])
    }
    
    private func setupSecondSeparatorConstraints() {
        NSLayoutConstraint.activate([
            secondSeparator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            secondSeparator.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            secondSeparator.bottomAnchor.constraint(equalTo: dateView.bottomAnchor),
        ])
    }
    
    private func setupAddReminderViewConstraints() {
        NSLayoutConstraint.activate([
            addReminderView.topAnchor.constraint(equalTo: secondSeparator.bottomAnchor),
            addReminderView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            addReminderView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            addReminderView.heightAnchor.constraint(equalTo: addReminderView.widthAnchor, multiplier: 0.15)
        ])
    }
    
    private func setupAddReminderButtonConstraints() {
        NSLayoutConstraint.activate([
            addReminderButton.centerXAnchor.constraint(equalTo: addReminderView.centerXAnchor),
            addReminderButton.centerYAnchor.constraint(equalTo: addReminderView.centerYAnchor)
        ])
    }
    
    private func setupReminderTableViewConstraints() {
        NSLayoutConstraint.activate([
            reminderTableView.topAnchor.constraint(equalTo: addReminderView.bottomAnchor, constant: 16),
            reminderTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            reminderTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            reminderTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension AddHabitView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == addHabitTextField {
            let updatedText = (textField.text as NSString? ?? "").replacingCharacters(in: range, with: string)
            
            updatedText.isEmpty ? updateAddHabitView(false) : updateAddHabitView(true)
        }
        return true
    }
}

extension AddHabitView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title:  "") { [weak self] action, view, actionPerformed in
            
            self?.reminderTableViewDelegate?.presentDeleteConfirmation(forReminderAt: indexPath) { confirmed in
                if confirmed {
                    self?.reminderTableViewDelegate?.deleteReminder(at: indexPath)
                    self?.reminderTableView.deleteRows(at: [indexPath], with: .fade)
                }
                actionPerformed(confirmed)
            }
        }
        
        deleteAction.image = .circularIcon(diameter: 35, iconName: UIImage.deleteCellImage, circleColor: .red, iconColor: .white)
        
        deleteAction.backgroundColor = .systemBackground
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension AddHabitView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reminderTableViewDelegate?.getReminderList().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .reminderCellIdentifier) as? ReminderCell,
              let reminderList = reminderTableViewDelegate?.getReminderList(),
              let reminder = reminderList[indexPath.row] as? Reminder
        else {
            return UITableViewCell()
        }
        cell.configure(reminder)
        return cell
    }
}
