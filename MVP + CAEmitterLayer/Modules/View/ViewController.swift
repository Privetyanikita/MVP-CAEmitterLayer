//
//  ViewController.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 12.12.24.
//

import UIKit
import SnapKit


class ViewController: UIViewController {

    private let crossImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private let statusProgressLabel: UILabel = {
        let element = UILabel()
        element.text = "0/10"
        element.textColor = .systemGray
        element.textAlignment = .center
        element.font = UIFont.systemFont(ofSize: 20)
        return element
    }()
    
    private let progtessBar = ProgressBarView()
    private let firstButton = CustomButton(with: .firstButton)
    private let secondButton = CustomButton(with: .secondButton)
    private let thirdButton = CustomButton(with: .thirdButton)
    private let fourthButton = CustomButton(with: .fourthButton)
    private var progressCounter:Int = 0 {
        didSet {
            if progressCounter < 0 {
                progressCounter = 0
            }
            else if progressCounter >= 10 {
                progressCounter = 10
            }
            statusProgressLabel.text = "\(progressCounter)/10"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraint()
        addTargets()
    }
    
    private func setupViews() {
        view.add(subviews: crossImageView, progtessBar, statusProgressLabel, firstButton, secondButton, thirdButton, fourthButton)
    }
    
    private func addTargets() {
        firstButton.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(thirdButtonTapped), for: .touchUpInside)
    }
    
    @objc private func firstButtonTapped() {
        let customAlert = CustomAlert()
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.modalTransitionStyle = .crossDissolve
        customAlert.preferredContentSize = CGSize(width: 300, height: 200)
        self.present(customAlert, animated: true, completion: nil)
    }
    
    @objc private func secondButtonTapped() {
        progressCounter += 1
        progtessBar.addProgress(0.1)
    }
    
    @objc private func thirdButtonTapped() {
        progressCounter -= 1
        progtessBar.addProgress(-0.1)
    }
    
}

extension ViewController {
    private func setupConstraint() {
        crossImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.width.equalTo(24)
        }
        
        statusProgressLabel.snp.makeConstraints { make in
            make.top.equalTo(crossImageView)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        progtessBar.snp.makeConstraints { make in
            make.centerY.equalTo(crossImageView)
            make.leading.equalTo(crossImageView.snp.trailing).offset(43)
            make.trailing.equalTo(statusProgressLabel.snp.leading).offset(-43)
            make.height.equalTo(13)
        }
        
        firstButton.snp.makeConstraints { make in
            make.top.equalTo(progtessBar.snp.bottom).offset(164)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(72)
        }
        
        secondButton.snp.makeConstraints { make in
            make.top.equalTo(firstButton.snp.bottom).offset(6)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(72)
        }
        
        thirdButton.snp.makeConstraints { make in
            make.top.equalTo(secondButton.snp.bottom).offset(6)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(72)
        }
        
        fourthButton.snp.makeConstraints { make in
            make.top.equalTo(thirdButton.snp.bottom).offset(6)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(72)
        }
    }
}

