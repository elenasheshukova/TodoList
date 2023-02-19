//
//  TasksRepository.swift
//  TodoList
//
//  Created by Елена Червоткина on 15.02.2023.
//

import Foundation

protocol ITaskRepository {
	func getList() -> [Task]
}

final class MockTaskRepository: ITaskRepository {
	func getList() -> [Task] {
		let list = [
			RegularTask(title: "Задача 1"),
			RegularTask(title: "Задача 2"),
			RegularTask(title: "Задача 3", status: .completed),
			ImportantTask(title: "Задача 5", priority: .low),
			ImportantTask(title: "Задача 6", priority: .medium),
			ImportantTask(title: "Задача 7", priority: .high)
		]
		return list
	}
}
