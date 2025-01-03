//
//  CustomButton.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 16.12.24.
//

import UIKit
import SnapKit

final class CustomButton: UIButton {
    //MARK: - Properties
    private let titleLable: UILabel = {
        let element = UILabel()
        element.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        element.textAlignment = .center
        element.numberOfLines = 1
        return element
    }()
    private let subTitleLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        element.textAlignment = .center
        element.numberOfLines = 1
        return element
    }()
    private var gradientLayer: CAGradientLayer?
    //MARK: - Init
    init(with: ButtonsType) {
        super.init(frame: .zero)
        switch with {
        case .firstButton:
            setupFirstButton()
        case .secondButton:
            setupSecondButton()
        case .thirdButton:
            setupThirdButton()
        case .fourthButton:
            setupFourthButton()
        }
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Methods
    private func setupFirstButton(){
        titleLable.text = "Показать Алерт".uppercased()
        titleLable.textColor = .black
        subTitleLabel.text = "Дополнительный текст".uppercased()
        subTitleLabel.textColor = .lightGray
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        addBottomBorder(width: 4, color: UIColor.lightGray)
    }
    
    private func setupSecondButton(){
        titleLable.text = "Увеличить прогрусс".uppercased()
        titleLable.textColor = .white
        subTitleLabel.text = "Текст".uppercased()
        subTitleLabel.textColor = .white
        self.backgroundColor = .red
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 210/255, green: 79/255, blue: 81/255, alpha: 1.0).cgColor
        addBottomBorder(width: 4, color: UIColor(red: 210/255, green: 79/255, blue: 81/255, alpha: 1.0))
    }
    
    private func setupThirdButton(){
        titleLable.text = "Уменьшить прогрусс".uppercased()
        titleLable.textColor = .white
        subTitleLabel.text = "Текст".uppercased()
        subTitleLabel.textColor = .white
        self.backgroundColor = .green
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 55/255, green: 178/255, blue: 77/255, alpha: 1.0).cgColor
        addBottomBorder(width: 4, color: UIColor(red: 55/255, green: 178/255, blue: 77/255, alpha: 1.0))
    }
    
    private func setupFourthButton(){
        titleLable.text = "Изменить Background".uppercased()
        titleLable.textColor = .black
        subTitleLabel.text = "Дополнительный текст".uppercased()
        subTitleLabel.textColor = .lightGray
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        addBottomBorder(width: 4, color: UIColor.lightGray)
        addCustomGradientToButton()
    }
    
    private func setupView() {
        self.add(subviews: titleLable, subTitleLabel)
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 2
    }
    
    private func addCustomGradientToButton() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 30/255, green: 213/255, blue: 27/255, alpha: 0.2).cgColor,
            UIColor(red: 255/255, green: 247/255, blue: 45/255, alpha: 0.2).cgColor,
            UIColor(red: 255/255, green: 183/255, blue: 44/255, alpha: 0.2).cgColor,
            UIColor(red: 232/255, green: 8/255, blue: 8/255, alpha: 0.2).cgColor,
            UIColor(red: 200/255, green: 8/255, blue: 232/255, alpha: 0.2).cgColor,
            UIColor(red: 39/255, green: 233/255, blue: 245/255, alpha: 0.2).cgColor
        ]
        gradientLayer.locations = [0.0, 0.2, 0.4, 0.6, 0.79, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = 16
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.gradientLayer = gradientLayer
    }
    
    private func addBottomBorder(width: CGFloat, color: UIColor) {
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = color.cgColor
        bottomBorder.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
        self.layer.addSublayer(bottomBorder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = self.bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateButton(scale: 0.95)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateButton(scale: 1.0)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animateButton(scale: 1.0)
    }
    
    private func animateButton(scale: CGFloat) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: nil)
    }
    
}
//MARK: - Setup Constraint
extension CustomButton {
    func setupConstraint() {
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(self).inset(10)
            make.leading.equalTo(self).inset(10)
            make.trailing.equalTo(self).inset(10)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(2)
            make.leading.equalTo(self).inset(10)
            make.trailing.equalTo(self).inset(10)
        }
    }
}
