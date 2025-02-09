//
//  HomeView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/8/24.
//

import UIKit

final class HomeView: UIView {
    
    weak var homeViewButtonActionDelegate: HomeViewButtonActionDelegate?
    weak var dropDownSelectionDelegate: DropDownSelectionDelegate?
    weak var habitTableViewDelegate: HabitTableViewDelegate?
    weak var futureHabitTableViewDelegate: FutureHabitTableViewDelegate?
    weak var homeViewDeleteCellDelegate: HomeViewDeleteCellDelegate?
    private let refreshControl = UIRefreshControl()
    private var dropDownTableView: DropDownTableView?
    
    var quoteLabelText: String? {
        willSet {
            quoteLabel.text = newValue
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.HomePage.myHabitsTitleLabel
        label.font = .rooneySansBold.withSize(28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .rooneySansRegular.withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dropDownButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.dropDownButtonImage, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dropDownButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.HomePage.doneButton, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .rooneySansBold.withSize(17)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var habitTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var futureHabitView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.accentColor.cgColor
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var futureHabitTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LocalizedStrings.Shared.habitPlaceholder
        textField.font = .rooneySansRegular.withSize(17)
        textField.placeholderColor = .lightGray
        textField.borderStyle = .none
        textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.Shared.saveButton, for: .normal)
        button.setTitleColor(.accentColor, for: .normal)
        button.titleLabel?.font = .rooneySansBold.withSize(16)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var futureHabitTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emptyViewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .emptyViewImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var emptyViewLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.HomePage.emptyViewLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .rooneySansBold.withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        futureHabitView.setCornerRadius(to: futureHabitView.bounds.height / 2)
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        [titleLabel, quoteLabel, doneButton, dropDownButton, habitTableView, futureHabitView, futureHabitTextField, saveButton, futureHabitTableView, emptyView].forEach(addSubview)
        [emptyViewImage, emptyViewLabel].forEach(emptyView.addSubview)
        setupConstraints()
        setupTableViewsConfigs()
        handlePullToRefresh()
        handleKeyboardDismiss()
    }
    
    private func setupConstraints() {
        setupTitleLabelConstraints()
        setupQuoteLabelConstraints()
        setupDropDownButtonConstraints()
        setupDoneButtonConstraints()
        setupHabitTableViewConstraints()
        setupFutureHabitViewConstraints()
        setupFutureHabitTextFieldConstraints()
        setupSaveButtonConstraints()
        setupFutureHabitTableViewConstraints()
        setupEmptyViewConstraints()
        setupEmptyViewImageConstraints()
        setupEmptyViewLabelConstraints()
    }
    
    @objc private func saveButtonTapped() {
        homeViewButtonActionDelegate?.saveButtonDidTapped(self, futureHabitTitle: futureHabitTextField.text ?? "")
        futureHabitTextField.text = nil
        futureHabitTableView.reloadData()
    }
    
    @objc private func doneButtonTapped() {
        toggleEditingMode()
    }
    
    @objc private func dropDownButtonTapped() {
        dismissKeyboard()
        dropDownTableView?.showDropDown(from: dropDownButton)
    }
    
    private func setupTableViewsConfigs() {
        setupHabitTableView()
        setupFutureHabitTableView()
        setupDropDownTableView()
    }
    
    private func setupHabitTableView() {
        habitTableView.delegate = self
        habitTableView.dataSource = self
        habitTableView.register(HabitCell.self, forCellReuseIdentifier: .habitCellIdentifier)
    }
    
    private func setupFutureHabitTableView() {
        futureHabitTableView.delegate = self
        futureHabitTableView.dataSource = self
        futureHabitTableView.register(FutureHabitCell.self, forCellReuseIdentifier: .futureHabitCellIdentifier)
    }
    
    private func setupDropDownTableView() {
        let dropDownData = [
            DropDownItem(title: LocalizedStrings.Cell.DropDown.addNewHabitOption, image: UIImage.dropDownAddNewHabitImage),
            DropDownItem(title: LocalizedStrings.Cell.DropDown.futureHabitShowHideOption, image: UIImage.dropDownFutureHabitShowHideImage),
            DropDownItem(title: LocalizedStrings.Cell.DropDown.editHabitListOption, image: UIImage.dropDownEditHabitListImage),
            DropDownItem(title: LocalizedStrings.Cell.DropDown
                            .quoteOffOption, image: UIImage.dropDownQuoteOffImage),
            DropDownItem(title: LocalizedStrings.Cell.DropDown.renameOption, image: UIImage.dropDownRenameImage),
        ]
        dropDownTableView = DropDownTableView(dropDownData: dropDownData)
        dropDownTableView?.delegate = self
    }
    
    private func handleKeyboardDismiss() {
        addKeyboardDismissTapGesture()
        addDoneButtonToKeyboard(for: futureHabitTextField)
    }
    
    private func handlePullToRefresh() {
        habitTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    }
    
    @objc func refreshTableView() {
        DispatchQueue.delay(1) { [weak self] in
            self?.habitTableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    func typingAnimation() {
        quoteLabel.typingAnimation(typingDelay: 0.05)
    }
    
    func setEmptyView(isHidden: Bool) {
        emptyView.isHidden = isHidden
    }
    
    func toggleHabitAndFutureHabitViews(isHidden: Bool) {
        habitTableView.isHidden.toggle()
        quoteLabel.isHidden.toggle()
        futureHabitTableView.isHidden.toggle()
        futureHabitView.isHidden.toggle()
        futureHabitTextField.isHidden.toggle()
        saveButton.isHidden.toggle()
        
        if saveButton.isHidden {
            setEmptyView(isHidden: isHidden)
            titleLabel.text = LocalizedStrings.HomePage.myHabitsTitleLabel
        } else {
            emptyView.isHidden = true
            titleLabel.text = LocalizedStrings.HomePage.futureHabitsTitleLabel
        }
        futureHabitTextField.text = ""
        futureHabitTableView.reloadData()
    }
    
    func toggleEditingMode() {
        habitTableView.isEditing.toggle()
        doneButton.isHidden.toggle()
        dropDownButton.isHidden.toggle()
    }
    
    func reloadHabitTableView() {
        habitTableView.reloadData()
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32)
        ])
    }
    
    private func setupQuoteLabelConstraints() {
        NSLayoutConstraint.activate([
            quoteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            quoteLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            quoteLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupDropDownButtonConstraints() {
        NSLayoutConstraint.activate([
            dropDownButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            dropDownButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
    
    private func setupDoneButtonConstraints() {
        NSLayoutConstraint.activate([
            doneButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            doneButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
    
    private func setupHabitTableViewConstraints() {
        NSLayoutConstraint.activate([
            habitTableView.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 16),
            habitTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            habitTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupEmptyViewConstraints() {
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 16),
            emptyView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            emptyView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupEmptyViewImageConstraints() {
        NSLayoutConstraint.activate([
            emptyViewImage.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 8),
            emptyViewImage.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 32),
            emptyViewImage.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -32),
            emptyViewImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupEmptyViewLabelConstraints() {
        NSLayoutConstraint.activate([
            emptyViewLabel.topAnchor.constraint(equalTo: emptyViewImage.bottomAnchor),
            emptyViewLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 32),
            emptyViewLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupFutureHabitViewConstraints() {
        NSLayoutConstraint.activate([
            futureHabitView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            futureHabitView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            futureHabitView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -80),
            futureHabitView.heightAnchor.constraint(equalTo: futureHabitView.widthAnchor, multiplier: 0.15)
        ])
    }
    
    private func setupFutureHabitTextFieldConstraints() {
        NSLayoutConstraint.activate([
            futureHabitTextField.topAnchor.constraint(equalTo: futureHabitView.topAnchor),
            futureHabitTextField.leadingAnchor.constraint(equalTo: futureHabitView.leadingAnchor, constant: 16),
            futureHabitTextField.bottomAnchor.constraint(equalTo: futureHabitView.bottomAnchor),
            futureHabitTextField.trailingAnchor.constraint(equalTo: futureHabitView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupSaveButtonConstraints() {
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            saveButton.centerYAnchor.constraint(equalTo: futureHabitTextField.centerYAnchor)
        ])
    }
    
    private func setupFutureHabitTableViewConstraints() {
        NSLayoutConstraint.activate([
            futureHabitTableView.topAnchor.constraint(equalTo: futureHabitTextField.bottomAnchor, constant: 16),
            futureHabitTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            futureHabitTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            futureHabitTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24)
        ])
    }
}

extension HomeView: DropDownTableViewDelegate {
    func dropDownTableView(_ tableView: DropDownTableView, didSelectItemAt index: Int) {
        dropDownSelectionDelegate?.handleDropDownSelection(index: index)
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        tableView == habitTableView ? 100 : 50
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if tableView == habitTableView {
            habitTableViewDelegate?.reorderHabits(from: sourceIndexPath, to: destinationIndexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        tableView == habitTableView ? configureSwipeActionsForHabitTable(at: indexPath) : configureSwipeActionsForFutureHabitTable(at: indexPath)
    }
    
    private func configureSwipeActionsForHabitTable(at indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let editAction = createEditAction(forHabitAt: indexPath)
        let deleteAction = createDeleteAction(forHabitAt: indexPath, tableViewType: .habit)
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    private func configureSwipeActionsForFutureHabitTable(at indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let deleteAction = createDeleteAction(forHabitAt: indexPath, tableViewType: .futureHabit)
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func createEditAction(forHabitAt indexPath: IndexPath) -> UIContextualAction {
        let editAction = UIContextualAction(style: .normal, title: nil) { [weak self] action, view, actionPerformed in
            
            self?.habitTableViewDelegate?.editHabit(at: indexPath)
            actionPerformed(true)
        }
        editAction.image = .circularIcon(diameter: 50, iconName: UIImage.editCellImage, circleColor: .blue, iconColor: .white)
        editAction.backgroundColor = .systemBackground
        return editAction
    }
    
    private func createDeleteAction(forHabitAt indexPath: IndexPath, tableViewType: TableViewType) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] action, view, actionPerformed in
            
            self?.homeViewDeleteCellDelegate?.presentDeleteConfirmation(forHabitAt: indexPath, tableViewType: tableViewType) { [weak self] confirmed in
            
                if confirmed {
                    if tableViewType == .habit {
                        self?.habitTableView.deleteRows(at: [indexPath], with: .fade)
                    } else {
                        self?.futureHabitTableView.deleteRows(at: [indexPath], with: .fade)
                    }
                } else {
                    actionPerformed(true)
                }
            }
        }
        
        let diameter: CGFloat
        if tableViewType == .habit {
            diameter = 50
        } else {
            diameter = 35
        }
        
        deleteAction.image = .circularIcon(diameter: diameter, iconName: UIImage.deleteCellImage, circleColor: .red, iconColor: .white)
        deleteAction.backgroundColor = .systemBackground
        return deleteAction
    }
}

extension HomeView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let habiList = habitTableViewDelegate?.getHabitList().count ?? 0
        let futureHabitList = futureHabitTableViewDelegate?.getFutureHabitList().count ?? 0
        
        return tableView == habitTableView ? habiList : futureHabitList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == habitTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .habitCellIdentifier) as? HabitCell,
                  let habitList = habitTableViewDelegate?.getHabitList(),
                  let habit = habitList[indexPath.row] as? Habit else {
                      return UITableViewCell()
                  }
            cell.configure(habit)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .futureHabitCellIdentifier) as? FutureHabitCell,
                  let futureHabitList = futureHabitTableViewDelegate?.getFutureHabitList(),
                  let futureHabit = futureHabitList[indexPath.row] as? FutureHabit else {
                      return UITableViewCell()
                  }
            cell.configure(futureHabit)
            return cell
        }
    }
}
