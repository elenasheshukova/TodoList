//
//  AuthInteractor.swift
//  TodoList
//
//  Created by Елена Червоткина on 22.02.2023.
//

import Foundation

protocol LoginDataStore
{
    var email: String? { get set }
    var password: String? { get set }
}

protocol IAuthInteractor {
    func login(request: AuthModels.Request)
}

class AuthInteractor: IAuthInteractor {
    private var worker: IAuthWorker
    private var presenter: IAuthPresenter?
    
    init(worker: IAuthWorker, presenter: IAuthPresenter) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func login(request: AuthModels.Request) {
        let result = worker.login(login: request.login, password: request.password)
        
        let responce = AuthModels.Responce(
            success: result.success == 1,
            login: result.login,
            lastLoginDate: result.lastLoginDate
        )
        
        presenter?.present(responce: responce)
    }
    
}
