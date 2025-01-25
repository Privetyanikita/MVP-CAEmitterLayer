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
    func updateProgressBar(action: ProgressBarAction)
    func randomColorBackground()
}

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    func updateProgress(action: ProgressAction)
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
    
    private func handleProgress(action: ProgressAction) {
            switch action {
            case .increment:
                model.increment()
                view?.updateProgressBar(action: .add)
            case .decrement:
                model.decrement()
                view?.updateProgressBar(action: .delete)
            case .reset:
                model.reset()
                view?.updateProgressBar(action: .reset)
            }
            updateView()
        }
}
//MARK: - MainPresenterProtocol
extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() {
        updateView()
    }
    
    func updateProgress(action: ProgressAction) {
        handleProgress(action: action)
    }
    
    func randomColorBackground() {
        view?.randomColorBackground()
    }
}
