//
//  Ext + UIView.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 22.12.24.
//

import UIKit

extension UIView {
    func add(subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
}
