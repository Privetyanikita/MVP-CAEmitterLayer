//
//  MainPresenter.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 29.12.24.
//

import UIKit

//MARK: - Protocol
protocol MainViewProtocol: AnyObject {
    func randomColorBackground()
}

protocol MainPresenterProtocol: AnyObject {
    func randomColorBackground()
}

final class MainPresenter {
    //MARK: - Properties
    weak var view: MainViewProtocol?

    //MARK: - Init
    init(view: MainViewProtocol) {
        self.view = view
    }
    
    //MARK: - Methods
    func showAlert(from viewController: UIViewController) {
        let customAlert = CustomAlert()
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.modalTransitionStyle = .crossDissolve
        customAlert.preferredContentSize = CGSize(width: 300, height: 200)
        viewController.present(customAlert, animated: true, completion: nil)
    }
}
//MARK: - MainPresenterProtocol
extension MainPresenter: MainPresenterProtocol {
    func randomColorBackground() {
        view?.randomColorBackground()
    }
}
