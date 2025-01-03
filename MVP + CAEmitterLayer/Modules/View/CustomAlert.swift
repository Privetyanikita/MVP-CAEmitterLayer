//
//  CustomAlert.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 02.01.25.
//

import UIKit
import SnapKit

final class CustomAlert: UIViewController {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        element.textAlignment = .center
        element.numberOfLines = 1
        element.textColor = .black
        element.text = "Введите ваше имя".uppercased()
        return element
    }()
    
    private let textField: UITextField = {
        let element = UITextField()
        element.placeholder = "Ваше имя".uppercased()
        element.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.textAlignment = .left
        element.backgroundColor = .clear
        element.textColor = .black
        return element
    }()
    
    private let saveButton: UIButton = {
        let element = UIButton()
        element.setTitle("Готово".uppercased(), for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.backgroundColor = .systemBlue
        element.layer.cornerRadius = 16
        element.layer.borderWidth = 2
        element.layer.borderColor = UIColor(red: 34/255, green: 139/255, blue: 230/255, alpha: 1.0).cgColor
        element.layer.shadowColor = UIColor(red: 34/255, green: 139/255, blue: 230/255, alpha: 1.0).cgColor
        element.layer.shadowOffset = CGSize(width: 0, height: 4)
        element.layer.shadowOpacity = 0.5
        element.layer.shadowRadius = 4
        return element
    }()
    
    private let backgroundView: UIView = {
        let element = UIView()
        element.backgroundColor = .systemGray5
        element.layer.cornerRadius = 16
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        setupBackgroundTapDismiss()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.add(subviews: containerView)
        containerView.add(subviews: titleLabel, backgroundView, textField, saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func setupBackgroundTapDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func backgroundTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !containerView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func saveButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension CustomAlert {
    private func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(36)
            make.trailing.equalToSuperview().inset(36)
            make.height.equalTo(24)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.leading.equalTo(textField.snp.leading).inset(-16)
            make.trailing.equalTo(textField.snp.trailing).offset(16)
            make.top.equalTo(textField.snp.top).offset(-12)
            make.bottom.equalTo(textField.snp.bottom).offset(12)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
    }
}
