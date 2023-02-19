//
//  ModuleBuilder.swift
//  TodoList
//
//  Created by Елена Червоткина on 19.02.2023.
//

import UIKit

protocol IBuilder {
    static func createTaskListModule() -> UIViewController
}

class ModuleBuilder: IBuilder {
    static func createTaskListModule() -> UIViewController {
        let taskManager = TaskManager()
        
        let view = TaskListViewController()
        let presenter = TaskListPresenter(view: view, taskManager: taskManager)
        view.presenter = presenter
        return view
    }
}
