//
//  TaskManager.swift
//  TodoList
//
//  Created by Елена Червоткина on 12.02.2023.
//

import Foundation

protocol ITaskManager {
//	func addTask(_ task: Task)
	func addTasks(_ tasks: [Task])
//	func deleteTask(_ task: Task)
	func getAll() -> [Task]
	func getCompleted() -> [Task]
	func getNotCompleted()-> [Task]
}

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
