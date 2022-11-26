//
//  TableHeaderFooter.swift
//  PersonalDataChildrenOfUserTestProject
//
//  Created by Andrei Nechitailo on 24.11.2022.
//

import Foundation
import SnapKit

class UserHeaderView: UIView {
    let titleLabel = UILabel()
    let titleFont = UIFont.boldSystemFont(ofSize: 18)
    let nameField = UserTextField(title: "Имя", placeholder: "Введите имя")
    let ageField = UserTextField(title: "Возраст", placeholder: "Введите возраст")
    let headerHeight = 230
    let headerWidth = UIScreen().bounds.width
    let childrenLabel = UILabel()
    let addChildButton = AddClearButton(mode: .add)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        self.bounds = CGRect(x: 0, y: 0, width: Int(headerWidth), height: headerHeight)
        titleLabel.text = "Персональные данные"
        titleLabel.font = titleFont
        childrenLabel.text = "Дети (макс. 5)"
        addSubview(titleLabel)
        addSubview(nameField)
        addSubview(ageField)
        addSubview(childrenLabel)
        addSubview(addChildButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(18)
            make.height.equalTo(20)
        }
        nameField.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(-18)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(nameField.staticHeight)
        }
        ageField.snp.makeConstraints { make in
            make.leading.equalTo(nameField)
            make.trailing.equalTo(-18)
            make.top.equalTo(nameField.snp.bottom).offset(10)
            make.height.equalTo(nameField)
        }
        addChildButton.snp.makeConstraints { make in
            make.top.equalTo(ageField.snp.bottom).offset(15)
            make.trailing.equalTo(ageField)
            make.height.equalTo(addChildButton.buttonHeight)
            make.width.equalTo(addChildButton.buttonWidth)
        }
        childrenLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.height.equalTo(titleLabel)
            make.centerY.equalTo(addChildButton)
        }
    }
    
    func reset() {
        nameField.textField.text = ""
        ageField.textField.text = ""
    }
}

class FooterView: UIView {
    let clearButton = AddClearButton(mode: .clear)
    let footerHeight = 110
    let footerWidth = UIScreen().bounds.width

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.bounds = CGRect(x: 0, y: 0, width: Int(footerWidth), height: footerHeight)
        addSubview(clearButton)
        clearButton.snp.makeConstraints { make in
            make.height.equalTo(clearButton.buttonHeight)
            make.width.equalTo(clearButton.buttonWidth)
            make.center.equalTo(self)
        }
    }
}
