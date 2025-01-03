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
        let model = ProgressModel()
        let presenter = MainPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
