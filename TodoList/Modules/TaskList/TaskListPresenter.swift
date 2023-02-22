//
//  TaskListPresenter.swift
//  TodoList
//
//  Created by Елена Червоткина on 19.02.2023.
//

import Foundation

protocol ITaskListPresenter {
	func present(responce: TaskListModels.Responce)
}

final class TaskListPresenter : ITaskListPresenter {
	private weak var view: ITaskListViewController?
	
	init(view: ITaskListViewController) {
		self.view = view
	}
	
	func present(responce: TaskListModels.Responce) {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		
		let sections = responce.sections.map { section in
			let tasks: [TaskListModels.ViewModel.Task] = section.tasks.map { task in
				if let task = task as? ImportantTask {
					return .importantTask(
						TaskListModels.ViewModel.ImportantTask(
							id: task.id,
							title: task.title,
							status: task.status,
							priority: task.priority,
							date: formatter.string(from: task.date),
							isOverdue: task.date < Date() && task.status != .completed
						)
					)
				} else {
					return .regularTask(
						TaskListModels.ViewModel.RegularTask(
							id: task.id,
							title: task.title,
							status: task.status
						)
					)
				}
			}
			
			return TaskListModels.ViewModel.Section(
				title: section.title,
				tasks: tasks
			)
		}
		
		view?.render(viewModel: TaskListModels.ViewModel(sections: sections))
	}
}
