//
//  ExampleTableViewCellItem.swift
//  Example-iOS
//
//  Created by Dmitry Frishbuter on 26/12/2016.
//  Copyright © 2016 Rosberry. All rights reserved.
//

import UIKit
import TableViewTools

class ExampleTableViewCellItem: TableViewCellItemProtocol, TableViewCellItemEditActionsProtocol {
    
    var itemDidSelectHandler: SelectionHandler?
    var reuseType = ReuseType(cellClass: ExampleTableViewCell.self)
    
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func height(in tableView: UITableView) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: ExampleTableViewCell = tableView.dequeueReusableCell()
        cell.titleLabel.text = title
        return cell
    }
    
    func canEdit(in tableView: UITableView) -> Bool {
        return true
    }

    func canCommit(_ editingStyle: UITableViewCell.EditingStyle, in tableView: UITableView) -> Bool {
        return true
    }
    
    func shouldShowMenu(in tableView: UITableView, forRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func canPerform(_ action: Selector, in tableView: UITableView, forRowAt indexPath: IndexPath, with sender: Any?) -> Bool {
        return action != #selector(UIResponderStandardEditActions.cut(_:))
    }
    
    func perform(_ action: Selector, in tableView: UITableView, forRowAt indexPath: IndexPath, with sender: Any?) {
        switch action {
        case #selector(UIResponderStandardEditActions.copy(_:)):
            UIPasteboard.general.string = title
        case #selector(UIResponderStandardEditActions.paste(_:)):
            title = UIPasteboard.general.string ?? title
            tableView.reloadRows(at: [indexPath], with: .none)
        default:
            break
        }
    }
    
    func canMoveRow(in tableView: UITableView, at indexPath: IndexPath) -> Bool {
        return true
    }
}
