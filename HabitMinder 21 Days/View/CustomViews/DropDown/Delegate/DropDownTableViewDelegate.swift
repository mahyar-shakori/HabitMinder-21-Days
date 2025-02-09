//
//  DropDownTableViewDelegate.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/12/25.
//

import UIKit

protocol DropDownTableViewDelegate: AnyObject {
    func dropDownTableView(_ tableView: DropDownTableView, didSelectItemAt index: Int)
}
