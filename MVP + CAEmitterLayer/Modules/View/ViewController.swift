//
//  ViewController.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 12.12.24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    //MARK: - Properties
    private let crossImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        element.contentMode = .scaleAspectFill
        element.isUserInteractionEnabled = true
        return element
    }()
    
    private let statusProgressLabel: UILabel = {
        let element = UILabel()
        element.text = "0/10"
        element.textColor = .black
        element.textAlignment = .center
        element.font = UIFont.systemFont(ofSize: 20)
        return element
    }()
    
    private let progressBar = ProgressBarView()
    private let firstButton = CustomButton(with: .firstButton)
    private let secondButton = CustomButton(with: .secondButton)
    private let thirdButton = CustomButton(with: .thirdButton)
    private let fourthButton = CustomButton(with: .fourthButton)
    private let confetti = ConfettiView()
    var presenter: MainPresenterProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraint()
        addTargets()
        presenter.viewDidLoad()
    }
    
    //MARK: - Methods
    private func setupViews() {
        view.add(subviews: crossImageView, progressBar, statusProgressLabel, firstButton, secondButton, thirdButton, fourthButton, confetti)
    }
    
    private func addTargets() {
        firstButton.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(thirdButtonTapped), for: .touchUpInside)
        fourthButton.addTarget(self, action: #selector(fourthButtonTapped), for: .touchUpInside)
        crossImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(crossButtonTapped)))
    }
    
    private func isColorDark(_ color: UIColor) -> Bool {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let brightness = (red * 299 + green * 587 + blue * 114) / 1000
        return brightness < 0.5
    }
    
    private func updateColors() {
        if isColorDark(view.backgroundColor ?? .white) {
            crossImageView.image = UIImage(systemName: "xmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            statusProgressLabel.textColor = .white
        } else {
            crossImageView.image = UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            statusProgressLabel.textColor = .black
        }
    }
    
    private func resetColors() {
        view.backgroundColor = .white
        crossImageView.image = UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        statusProgressLabel.textColor = .label
    }
    
    func showConfetti() {
        confetti.startConfetti()
    }
    
    func checkProgress() {
        if progressBar.progress > 0.9 {
            confetti.layoutIfNeeded()
            showConfetti()
        }
    }
    
    //MARK: - Actions
    @objc private func firstButtonTapped() {
        let customAlert = CustomAlert()
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.modalTransitionStyle = .crossDissolve
        customAlert.preferredContentSize = CGSize(width: 300, height: 200)
        self.present(customAlert, animated: true, completion: nil)
    }
    
    @objc private func secondButtonTapped() {
        presenter.updateProgress(action: .increment)
        checkProgress()
    }
    
    @objc private func thirdButtonTapped() {
        presenter.updateProgress(action: .decrement)
    }
    
    @objc private func fourthButtonTapped() {
        presenter.randomColorBackground()
    }
    
    @objc private func crossButtonTapped() {
        presenter.updateProgress(action: .reset)
        resetColors()
    }
    
}
//MARK: - Setup Constraint
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
        
        progressBar.snp.makeConstraints { make in
            make.centerY.equalTo(crossImageView)
            make.leading.equalTo(crossImageView.snp.trailing).offset(43)
            make.width.equalTo(210)
            make.height.equalTo(13)
        }
        
        firstButton.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(164)
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
        
        confetti.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

// MARK: - MainViewProtocol Implementation
extension ViewController: MainViewProtocol {
    func updateProgressLabel(text: String) {
        statusProgressLabel.text = text
    }
    
    func updateProgressBar(action: ProgressBarAction) {
        switch action {
        case .add:
            progressBar.addProgress()
        case .delete:
            progressBar.deleteProgress()
        case .reset:
            progressBar.resetProgress()
        }
    }
    
    func randomColorBackground() {
        view.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
        updateColors()
    }
}

