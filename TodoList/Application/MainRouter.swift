//
//  MainRouter.swift
//  TodoList
//
//  Created by Елена Червоткина on 22.02.2023.
//

import UIKit


protocol IRouter {
	static func navigateToTodoList(source: UIViewController)
}

class MainRouter: IRouter {
	static func navigateToTodoList(source: UIViewController){
		let taskManager = TaskManager()
		let vc = TaskListViewController(taskManager: taskManager)
		vc.modalPresentationStyle = .fullScreen
		source.show(vc, sender: nil)
	}
}
