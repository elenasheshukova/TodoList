//
//  AuthModels.swift
//  TodoList
//
//  Created by Елена Червоткина on 22.02.2023.
//

import Foundation

enum AuthModels {
    struct Request {
        var login: String
        var password: String
    }
    
    struct Responce {
        var success: Bool
        var login: String
        var lastLoginDate: Date
    }
    
    struct ViewModel {
        var success: Bool
        var userName: String
        var lastLoginDate: String
    }
}
