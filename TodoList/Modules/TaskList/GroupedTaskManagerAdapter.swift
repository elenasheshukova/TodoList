//
//  GroupedTaskManagerAdapter.swift
//  TodoList
//
//  Created by Елена Червоткина on 16.02.2023.
//

import Foundation

///Протокол
protocol IGroupedTaskManagerAdapter {
	/// Получить список секций
	/// - Returns: список заголовков секций
	func getSectionsTitles() -> [String]
	
	/// Получить список задач для секции
	/// - Parameter title: заголовок секции
	/// - Returns: список задач
	func getTasksForSections(title: String?) -> [Task]
}

/// Группирует задачи на основании их статусов
final class GroupedTaskManagerAdapter : IGroupedTaskManagerAdapter {
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	func getSectionsTitles() -> [String] {
		Status.allCases.map { $0.rawValue }
	}
	
	func getTasksForSections(title: String?) -> [Task] {
		guard let title = title else {
			return taskManager.getAll()
		}
		
		guard let status = Status(rawValue: title) else { return [] }
		
		switch status {
		case .completed:
			return taskManager.getCompleted()
		case .notCompleted:
			return taskManager.getNotCompleted()
		}
	}
}
