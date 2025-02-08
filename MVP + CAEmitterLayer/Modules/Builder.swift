//
//  Builder.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 03.01.25.
//

import Foundation

final class Builder {
    static func build() -> ViewController {
        let view = ViewController()
        let presenter = MainPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
