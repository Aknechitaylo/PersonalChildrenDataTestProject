//
//  Classes.swift
//  PersonalDataChildrenOfUserTestProject
//
//  Created by Andrei Nechitailo on 10.11.2022.
//

import Foundation
import UIKit
import SnapKit

class UserTextField: UIView {
    let label = UILabel()
    let textField = UITextField()
    let staticHeight = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, placeholder: String) {
        self.init(frame: CGRectZero)
        label.text = title
        textField.placeholder = placeholder
        setupUI()
    }
    
    private func setupUI() {
        layer.borderWidth = 1.5
        layer.borderColor = CGColor(gray: 0.9, alpha: 1)
        layer.cornerRadius = CGFloat(staticHeight/10)
        addSubview(label)
        label.font = UIFont.systemFont(ofSize: 15)
        label.alpha = 0.5
        addSubview(textField)
        textField.font = UIFont.systemFont(ofSize: 15)
        setupConstraints()
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(18)
            make.height.equalTo(18)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(5)
            make.leading.equalTo(label)
            make.height.equalTo(label)
        }
    }
    
}

class AddClearButton: UIButton {
    enum ButtonMode {
        case add
        case clear
    }
    
    var delegate: AddClearButtonDelegate?
    let mode: ButtonMode
    let buttonHeight = 50
    let buttonWidth = 200

    init(mode: AddClearButton.ButtonMode) {
        self.mode = mode
        super.init(frame: CGRectZero)
        setupButton()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        switch mode {
        case .add:
            setupAddButtonStyle()
            addTarget(self, action: #selector(self.addChildAction(sender:)), for: .touchDown)
        case .clear:
            setupClearButtonStyle()
            addTarget(self, action: #selector(self.clearAction(sender:)), for: .touchUpInside)
        }
        addTarget(self, action: #selector(touchDown(sender:)), for: .touchDown)
        addTarget(self, action: #selector(touchUp(sender:)), for: .touchUpInside)
        addTarget(self, action: #selector(touchUp(sender:)), for: .touchUpOutside)
        layer.cornerRadius = CGFloat(buttonHeight/2)
        layer.borderWidth = 2
    }
    
    private func setupAddButtonStyle() {
//        let systemBlue = UIColor(red: 52, green: 120, blue: 246, alpha: 1)
        setTitle("+ Добавить ребёнка", for: .normal)
        setColor(UIColor.systemBlue)
    }
    
    private func setupClearButtonStyle() {
        setTitle("Очистить", for: .normal)
        setColor(UIColor.systemRed)
    }
    
    private func setColor(_ color: UIColor) {
        setTitleColor(color, for: .normal)
        layer.borderColor = color.cgColor
    }

    @objc private func touchDown(sender: UIButton) {
        alpha = 0.33
    }
    
    @objc private func touchUp(sender: UIButton) {
        UIView.animate(withDuration: 0.33) {
            self.alpha = 1
        }
    }
    
    @objc private func addChildAction(sender: AddClearButton) {
        self.delegate?.buttonTapped(sender: sender)
    }
    
    @objc private func clearAction(sender: AddClearButton) {
        self.delegate?.buttonTapped(sender: sender)
    }
}

protocol AddClearButtonDelegate: AnyObject {
    func buttonTapped(sender: AddClearButton)
}
