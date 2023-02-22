//
//  AuthPresenter.swift
//  TodoList
//
//  Created by Елена Червоткина on 22.02.2023.
//

import UIKit

protocol IAuthPresenter {
    func present(responce: AuthModels.Responce)
}

class AuthPresenter: IAuthPresenter {
    private weak var view: IAuthViewController?
    
    init(view: IAuthViewController?) {
        self.view = view
    }
    
    func present(responce: AuthModels.Responce) {
        let viewModel = AuthModels.ViewModel(
            success: responce.success,
            userName: responce.login,
            lastLoginDate: "\(responce.lastLoginDate)"
        )
        view?.render(viewModel: viewModel)
    }
}
