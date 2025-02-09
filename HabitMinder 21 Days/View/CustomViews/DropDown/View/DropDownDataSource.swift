//
//  DropDownDataSource.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/12/25.
//

import UIKit

extension DropDownTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dropDownData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .dropDownCellIdentifier, for: indexPath) as? DropDownCell else {
            return UITableViewCell()
        }
        let item = dropDownData[indexPath.row]
        cell.configure(title: item.title, image: item.image)
        return cell
    }
}
