//
//  DropDownTableView+Delegate .swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/23/25.
//

import UIKit

extension DropDownTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
        self.delegate?.dropDownTableView(self, didSelectItemAt: indexPath.row)
    }
}
