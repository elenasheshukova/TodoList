//
//  AuthWorker.swift
//  TodoList
//
//  Created by Елена Червоткина on 22.02.2023.
//

import Foundation

public struct LoginDTO {
    var success: Int
    var login: String
    var lastLoginDate: Date
}

protocol IAuthWorker {
    func login(login: String, password: String) -> LoginDTO
}

class AuthWorker: IAuthWorker {
    func login(login: String, password: String) -> LoginDTO {
        
        if login == "Admin" && password == "pa$$32!" {
            return LoginDTO(
                success: 1,
                login: login,
                lastLoginDate: Date()
            )
        } else {
            return LoginDTO(
                success: 0,
                login: login,
                lastLoginDate: Date()
            )
        }
    }

}
