//
//  CustomAlert.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 02.01.25.
//

import UIKit
import SnapKit

final class CustomAlert: UIViewController {
    //MARK: - Properties
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
        element.text = MockData.inputYourName.rawValue.uppercased()
        return element
    }()
    
    private let textField: UITextField = {
        let element = UITextField()
        element.placeholder = MockData.yourName.rawValue.uppercased()
        element.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        element.textAlignment = .left
        element.backgroundColor = .clear
        element.textColor = .black
        return element
    }()
    
    private let backgroundView: UIView = {
        let element = UIView()
        element.backgroundColor = .systemGray5
        element.layer.cornerRadius = 16
        return element
    }()
    
    private let saveButton = CustomButtonAlert()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        setupView()
        setupConstraint()
        setupBackgroundTapDismiss()
    }
    
    //MARK: - Methods
    private func setupView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.add(subviews: containerView)
        containerView.add(subviews: titleLabel, backgroundView, textField, saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(handleTouchDown), for: .touchDown)
        saveButton.addTarget(self, action: #selector(handleTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    private func setupBackgroundTapDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - OBJC Methods
    @objc private func backgroundTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !containerView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func saveButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleTouchDown() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseIn], animations: {
            self.saveButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }

    @objc private func handleTouchUp() {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: [.curveEaseOut], animations: {
            self.saveButton.transform = .identity
        }, completion: nil)
    }
}

//MARK: - Ext
extension CustomAlert: UITextFieldDelegate {
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.isEmpty {
            saveButton.inactive()
        } else {
            saveButton.active()
        }
        return true
    }
}
