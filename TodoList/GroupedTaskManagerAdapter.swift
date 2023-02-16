//
//  GroupedTaskManagerAdapter.swift
//  TodoList
//
//  Created by Елена Червоткина on 16.02.2023.
//

import Foundation

protocol IGroupedTaskManagerAdapter {
	func getSectionsTitles() -> [String]
	func getTasksForSections(sectionIndex: Int) -> [Task]
}

final class GroupedTaskManagerAdapter : IGroupedTaskManagerAdapter {
	private let taskManager: ITaskManager
	private let sections = Status.allCases
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	func getSectionsTitles() -> [String] {
		sections.map { $0.rawValue }
	}
	
	func getTasksForSections(sectionIndex: Int) -> [Task] {
		guard sectionIndex < sections.count else {
			return []
		}
		switch sections[sectionIndex] {
		case .completed:
			return taskManager.getCompleted()
		case .notCompleted:
			return taskManager.getNotCompleted()
		}
	}
}
