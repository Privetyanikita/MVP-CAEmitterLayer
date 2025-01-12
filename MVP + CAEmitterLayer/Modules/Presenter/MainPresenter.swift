//
//  MainPresenter.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 29.12.24.
//

import UIKit

//MARK: - Protocol
protocol MainViewProtocol: AnyObject {
    func updateProgressLabel(text: String)
    func addProgress()
    func deleteProgress()
    func resetProgressBar()
    func randomColorBackground()
}

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    func incrementProgress()
    func decrementProgress()
    func resetProgress()
    func randomColorBackground()
}

final class MainPresenter {
    //MARK: - Properties
    private var model: ProgressModel
    weak var view: MainViewProtocol?

    //MARK: - Init
    init(view: MainViewProtocol, model: ProgressModel) {
        self.view = view
        self.model = model
    }
    
    //MARK: - Methods
    private func updateView() {
        view?.updateProgressLabel(text: "\(model.progress)/\(model.maxProgress)")
    }

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
    func viewDidLoad() {
        updateView()
    }

    func incrementProgress() {
        model.increment()
        updateView()
        view?.addProgress()
    }

    func decrementProgress() {
        model.decrement()
        updateView()
        view?.deleteProgress()
    }

    func resetProgress() {
        model.reset()
        updateView()
        view?.resetProgressBar()
    }
    
    func randomColorBackground() {
        view?.randomColorBackground()
    }
}
