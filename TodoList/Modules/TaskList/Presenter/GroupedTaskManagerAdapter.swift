//
//  GroupedTaskManagerAdapter.swift
//  TodoList
//
//  Created by Елена Червоткина on 16.02.2023.
//

import Foundation

protocol IGroupedTaskManagerAdapter {
	func getSectionsTitles() -> [String]
	func getTasksForSections(title: String) -> [Task]
}

final class GroupedTaskManagerAdapter : IGroupedTaskManagerAdapter {
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	func getSectionsTitles() -> [String] {
        Status.allCases.map { $0.rawValue }
	}
    
    func getTasksForSections(title: String) -> [Task] {
        guard let status = Status(rawValue: title) else { return [] }
        
        switch status {
        case .completed:
            return taskManager.getCompleted()
        case .notCompleted:
            return taskManager.getNotCompleted()
        }
    }
}
