//
//  TaskManager.swift
//  TodoList
//
//  Created by Елена Червоткина on 12.02.2023.
//

import Foundation

protocol ITaskManager {
	/// Добавить список задач
	/// - Parameter tasks: список задач
	func addTasks(_ tasks: [Task])
	
	/// Получить список всех задач
	/// - Returns: список задач
	func getAll() -> [Task]
	
	/// Получить список выполненных задач
	/// - Returns: список задач
	func getCompleted() -> [Task]
	
	/// Получить список незавершенных задач
	/// - Returns: список задач
	func getNotCompleted()-> [Task]
}

/// Предоставляет список задач.
class TaskManager: ITaskManager {
	private var list: [Task] = []
	
	func addTask(_ task: Task) {
		list.append(task)
	}
	
	func deleteTask(_ task: Task) {
		list.removeAll(where: {$0 === task})
	}
	
	func addTasks(_ tasks: [Task]) {
		list.append(contentsOf: tasks)
	}
	
	func getAll() -> [Task] {
		list
	}
	
	func getCompleted() -> [Task] {
		list.filter{ $0.status == .completed }
	}
	
	func getNotCompleted() -> [Task] {
		list.filter{ $0.status != .completed }
	}
}
