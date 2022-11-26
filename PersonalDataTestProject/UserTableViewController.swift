//
//  UserTableViewController.swift
//  PersonalDataChildrenOfUserTestProject
//
//  Created by Andrei Nechitailo on 08.11.2022.
//

import UIKit

class UserTableViewController: UITableViewController {
    let headerView = UserHeaderView()
    let footerView = FooterView()
    
    let childCellId = "childCellId"
    let childRowHeight = 180
    let clearRowHeight = 80
    var rowsCount = 0
    var uniqueCellTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addChildButton.delegate = self
        footerView.clearButton.delegate = self
        tableView.register(ChildCell.self, forCellReuseIdentifier: childCellId)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.keyboardDismissMode = .interactive
    }
}

extension UserTableViewController {
    //MARK: TableViewDatasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        headerView.addChildButton.isHidden = (rowsCount > 4)
        return rowsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: childCellId) as! ChildCell
        cell.delegate = self
        return cell
    }
    
    //MARK: TableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    private func showResetContentAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let resetAction = UIAlertAction(title: "Сбросить данные", style: .destructive) {_ in
            self.rowsCount = 0
            self.headerView.reset()
            self.tableView.reloadData()
        }
        alert.addAction(resetAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
}

//MARK: AddClearButtonDelegate
extension UserTableViewController: AddClearButtonDelegate {
    func buttonTapped(sender: AddClearButton) {
        switch sender.mode {
        case .add:
            rowsCount += 1
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)] , with: .automatic)
            tableView.endUpdates()
        case .clear:
            showResetContentAlert()
        }
    }
}

//MARK: AddClearButtonDelegate
extension UserTableViewController: ChildCellDelegate {
    func deleteButtonDidTouch(cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        rowsCount -= 1
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}

