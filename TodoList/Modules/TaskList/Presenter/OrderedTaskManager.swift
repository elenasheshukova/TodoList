//
//  TaskManagerDecorator.swift
//  TodoList
//
//  Created by Елена Червоткина on 15.02.2023.
//

import Foundation

/// Предоставляет список заданий, отсортированных по приоритету.
final class OrderedTaskManager: ITaskManager {
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	func addTasks(_ tasks: [Task]) {
		taskManager.addTasks(tasks)
	}
	
	func getAll() -> [Task] {
		sortByPriority(taskManager.getAll())
	}
	
	func getCompleted() -> [Task] {
		sortByPriority(taskManager.getCompleted())
	}
	
	func getNotCompleted() -> [Task] {
		sortByPriority(taskManager.getNotCompleted())
	}
	
	private func sortByPriority(_ tasks: [Task]) -> [Task]{
		tasks.sorted {
			if let task1 = $0 as? ImportantTask {
				if let task2 = $1 as? ImportantTask {
					return task1.priority.rawValue > task2.priority.rawValue
				}
				return true
			}
			return false
		}
	}
}
