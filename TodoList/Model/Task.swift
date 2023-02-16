//
//  Task.swift
//  TodoList
//
//  Created by Елена Червоткина on 15.02.2023.
//

import Foundation

class Task {
	let id = UUID()
	var title: String
	var status: Status
	
	init(title: String, status: Status = .notCompleted) {
		self.title = title
		self.status = status
	}
}

class RegularTask: Task {}

class ImportantTask: Task {
	var priority: Priority
	
	var date: Date {
		var dateComponents = DateComponents()
		switch self.priority {
		case .high:
			dateComponents.day = 1
		case .medium:
			dateComponents.day = 2
		case .low:
			dateComponents.day = 3
		}
		return Calendar.current.date(byAdding: dateComponents, to: Date()) ?? Date()
	}
	
	init(title: String, priority: Priority) {
		self.priority = priority
		super.init(title: title)
	}
}

enum Status: String, CaseIterable {
	case notCompleted = "Незавершенные"
	case completed = "Завершенные"
}

enum Priority: Int {
	case low = 1
	case medium = 2
	case high = 3
}
