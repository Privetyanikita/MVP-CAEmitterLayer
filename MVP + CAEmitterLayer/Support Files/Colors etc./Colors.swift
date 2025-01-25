//
//  Colors.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 25.01.25.
//

import UIKit

enum Color {
    case blue
    case red
    case green
    
    var uiColor: UIColor {
        switch self {
        case .blue:
            UIColor(red: 34/255, green: 139/255, blue: 230/255, alpha: 1.0)
        case .red:
            UIColor(red: 210/255, green: 79/255, blue: 81/255, alpha: 1.0)
        case .green:
            UIColor(red: 55/255, green: 178/255, blue: 77/255, alpha: 1.0)
        }
    }
}

enum Colors {
    case gradient
    
    var cgColor: [CGColor] {
        switch self {
        case .gradient:
            [
                UIColor(red: 30/255, green: 213/255, blue: 27/255, alpha: 0.2).cgColor,
                UIColor(red: 255/255, green: 247/255, blue: 45/255, alpha: 0.2).cgColor,
                UIColor(red: 255/255, green: 183/255, blue: 44/255, alpha: 0.2).cgColor,
                UIColor(red: 232/255, green: 8/255, blue: 8/255, alpha: 0.2).cgColor,
                UIColor(red: 200/255, green: 8/255, blue: 232/255, alpha: 0.2).cgColor,
                UIColor(red: 39/255, green: 233/255, blue: 245/255, alpha: 0.2).cgColor
            ]
        }
    }
}
