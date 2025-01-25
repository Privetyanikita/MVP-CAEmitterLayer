//
//  CustomButtonAlert.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 25.01.25.
//

import UIKit
import SnapKit

final class CustomButtonAlert: UIButton {
    private let backgroundView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 16
        element.clipsToBounds = true
        element.isUserInteractionEnabled = false
        element.backgroundColor = Color.blue.uiColor
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.add(subviews: backgroundView)
        self.setTitle(MockData.done.rawValue.uppercased(), for: .normal)
        self.setTitleColor(.gray, for: .normal)
        self.backgroundColor = Color.blueBorder.uiColor
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 2
        self.layer.borderColor = .init(gray: 1, alpha: 1)
    }
}

extension CustomButtonAlert {
    private func setupConstrains() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
    }
}
