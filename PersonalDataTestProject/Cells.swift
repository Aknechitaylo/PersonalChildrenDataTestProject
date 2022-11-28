//
//  Cells.swift
//  PersonalDataChildrenOfUserTestProject
//
//  Created by Andrei Nechitailo on 10.11.2022.
//

import Foundation
import UIKit
import SnapKit

class ChildCell: UITableViewCell {
    let nameField = UserTextField(title: "Имя", placeholder: "Введите имя ребёнка", keyboardType: .namePhonePad)
    let ageField = UserTextField(title: "Возраст", placeholder: "Введите возраст ребёнка", keyboardType: .numberPad)
    let deleteButton = UIButton(type: .system)
    let staticFieldWidth = 210
    var delegate: ChildCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(nameField)
        contentView.addSubview(ageField)
        contentView.addSubview(deleteButton)
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 17)
        deleteButton.addTarget(self, action: #selector(deleteButtonTouched), for: .touchUpInside)

        nameField.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(18)
            make.height.equalTo(nameField.staticHeight)
            make.width.equalTo(self.staticFieldWidth)
        }
        ageField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(18)
            make.leading.equalTo(nameField)
            make.height.equalTo(nameField)
            make.width.equalTo(nameField)
        }
        deleteButton.snp.makeConstraints { make in
            make.leading.equalTo(nameField.snp.trailing).offset(18)
            make.centerY.equalTo(nameField)
        }
    }
    
    public func reset() {
        nameField.textField.text = ""
        ageField.textField.text = ""
    }
    
    @objc private func deleteButtonTouched() {
        self.delegate?.deleteButtonDidTouch(cell: self)
    }
}

protocol ChildCellDelegate {
    func deleteButtonDidTouch(cell: ChildCell)
}

