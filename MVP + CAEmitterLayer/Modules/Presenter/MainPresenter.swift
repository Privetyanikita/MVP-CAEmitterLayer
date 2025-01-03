//
//  MainPresenter.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 29.12.24.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
}

protocol MainPresenterProtocol: AnyObject {
    
}

final class MainPresenter {
    weak var view: MainViewProtocol?
}
