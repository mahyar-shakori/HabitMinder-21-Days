//
//  DropDownTableView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/9/24.
//

import UIKit

final class DropDownTableView: UIView {
    
    weak var delegate: DropDownTableViewDelegate?
    private(set) var dropDownData: [DropDownItem]
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 50
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .systemGray6
        table.register(DropDownCell.self, forCellReuseIdentifier: .dropDownCellIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init(dropDownData: [DropDownItem]) {
        self.dropDownData = dropDownData
        super.init(frame: .zero)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
#if DEBUG
        fatalError("init(coder:) has not been implemented")
#else
        super.init(coder: coder)
#endif
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.pinToSafeArea()
        addTapGestureRecognizers()
    }
    
    private func addTapGestureRecognizers() {
        let tableTapGesture = UITapGestureRecognizer(target: self, action: #selector(tableTapped))
        tableView.addGestureRecognizer(tableTapGesture)
    }
    
    private func calculateHeight() -> CGFloat {
        CGFloat(dropDownData.count) * tableView.rowHeight + 10
    }
    
    func showDropDown(from view: UIView) {
        guard let superview = view.superview else {
            return
        }
        addToSuperview(superview: superview)
    }
    
    private func addToSuperview(superview: UIView) {
        let dropDownHeight = calculateHeight()
        frame = CGRect(x: 0, y: superview.frame.height - dropDownHeight, width: UIScreen.main.bounds.width, height: dropDownHeight)
        superview.addSubview(self)
        setupCornerRadius(dropDownHeight: dropDownHeight)
        animateDropDownAppearance(dropDownHeight: dropDownHeight)
        addOutsideTapGesture(to: superview)
    }
    
    private func setupCornerRadius(dropDownHeight: CGFloat) {
        layer.cornerRadius = dropDownHeight / 10
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func animateDropDownAppearance(dropDownHeight: CGFloat) {
        frame.origin.y += dropDownHeight
        UIView.animate(withDuration: 0.3) {
            self.frame.origin.y -= dropDownHeight
        }
    }
    
    private func addOutsideTapGesture(to view: UIView) {
        let outsideTapGesture = UITapGestureRecognizer(target: self, action: #selector(outsideTapped))
        view.addGestureRecognizer(outsideTapGesture)
    }
   
    @objc private func outsideTapped(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: gesture.view)
        
        if frame.contains(tapLocation) {
            return
        }
        removeFromSuperview()
    }

    @objc private func tableTapped(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: location) else {
            return
        }
        delegate?.dropDownTableView(self, didSelectItemAt: indexPath.row)
        removeFromSuperview()
    }
}
