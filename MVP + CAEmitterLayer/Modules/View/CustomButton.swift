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
    
    private let backgroundView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 16
        element.clipsToBounds = true
        element.isUserInteractionEnabled = false
        return element
    }()
    
    private var gradientLayer: CAGradientLayer?
    
    //MARK: - Init
    init(with: ButtonsType) {
        super.init(frame: .zero)
        switch with {
        case .firstButton:
            setupButton(title: MockData.showAlert.rawValue,
                        titleColor: .black,
                        subTitle: MockData.suplementaryText.rawValue,
                        subTitleColor: .lightGray,
                        backgroundColor: .white,
                        borderColor: .systemGray4)
        case .secondButton:
            setupButton(title: MockData.incrementProgress.rawValue,
                        titleColor: .white,
                        subTitle: MockData.text.rawValue,
                        subTitleColor: .white,
                        backgroundColor: Color.red.uiColor,
                        borderColor: Color.redBorder.uiColor)
        case .thirdButton:
            setupButton(title: MockData.decrementProgress.rawValue,
                        titleColor: .white,
                        subTitle: MockData.text.rawValue,
                        subTitleColor: .white,
                        backgroundColor: Color.green.uiColor,
                        borderColor: Color.greenBorder.uiColor)
        case .fourthButton:
            setupButton(title: MockData.changesBackground.rawValue,
                        titleColor: .black,
                        subTitle: MockData.suplementaryText.rawValue,
                        subTitleColor: .lightGray,
                        backgroundColor: Colors.gradient.cgColor,
                        borderColor: .systemGray4)
        }
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods    
    private func setupButton(title: String, titleColor: UIColor, subTitle: String, subTitleColor: UIColor, backgroundColor: UIColor, borderColor: UIColor){
        titleLable.text = title.uppercased()
        titleLable.textColor = titleColor
        subTitleLabel.text = subTitle.uppercased()
        subTitleLabel.textColor = subTitleColor
        backgroundView.backgroundColor = backgroundColor
        self.backgroundColor = borderColor
        self.layer.borderColor = borderColor.cgColor
    }
    
    private func setupButton(title: String, titleColor: UIColor, subTitle: String, subTitleColor: UIColor, backgroundColor: [CGColor], borderColor: UIColor){
        titleLable.text = title.uppercased()
        titleLable.textColor = titleColor
        subTitleLabel.text = subTitle.uppercased()
        subTitleLabel.textColor = subTitleColor
        backgroundView.backgroundColor = .white
        self.backgroundColor = borderColor
        self.layer.borderColor = borderColor.cgColor
        addCustomGradientToButton(colors: backgroundColor)
    }
    
    private func setupView() {
        self.add(subviews: backgroundView, titleLable, subTitleLabel)
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 2
    }
    
    private func addCustomGradientToButton(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Colors.gradient.cgColor
        gradientLayer.locations = [0.0, 0.2, 0.4, 0.6, 0.79, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = 16
        gradientLayer.frame = backgroundView.bounds
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        self.gradientLayer = gradientLayer
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
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
        
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
