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
    let childRowHeight: CGFloat = 180
    var rowsCount = 0
    
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
        return childRowHeight
    }
    
    private func showResetContentAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let resetAction = UIAlertAction(title: "Сбросить данные", style: .destructive) {_ in
            self.resetTableView()
        }
        alert.addAction(resetAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
    
    private func resetTableView() {
        headerView.reset()
        resetCells()
        rowsCount = 0
        tableView.reloadData()
    }
    
    private func resetCells() {
        guard rowsCount > 0 else { return }
        for row in 1...rowsCount-1 {
            let indexPath = IndexPath(row: row, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! ChildCell
            cell.reset()
        }
    }
}

//MARK: AddClearButtonDelegate
extension UserTableViewController: AddClearButtonDelegate {
    func buttonTapped(sender: AddClearButton) {
        switch sender.mode {
        case .add:
            rowsCount += 1
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath] , with: .automatic)
            tableView.endUpdates()
        case .clear:
            showResetContentAlert()
        }
    }
}

//MARK: AddClearButtonDelegate
extension UserTableViewController: ChildCellDelegate {
    func deleteButtonDidTouch(cell: ChildCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        rowsCount -= 1
        tableView.performBatchUpdates({
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }) { finishes in
            cell.reset()
        }
    }
}

