//
//  TaskListViewData.swift
//  TodoList
//
//  Created by Елена Червоткина on 19.02.2023.
//

import Foundation

/// Модель данных для TaskListViewController
final class TaskListViewData {
	var sections: [TaskSection] = []
}

final class TaskSection {
	var title: String
	var tasks: [Task]
	
	init(title: String, tasks: [Task]) {
		self.title = title
		self.tasks = tasks
	}
}


enum TaskListModels {
    struct Request {
        struct changeTaskStatus {
            var id: UUID
            var status: Status
        }
    }
    
    struct Responce {
        struct Section {
            var title: String
            var tasks: [Task]
        }
        
        let sections: [Section]
    }
    
    struct ViewModel {
        struct RegularTask{
			let id: UUID
            var title: String
            var status: Status
        }
        
        struct ImportantTask{
			let id: UUID
            var title: String
            var status: Status
            var priority: Priority
            var date: String
            var isOverdue: Bool
        }
        
        enum Task {
            case regularTask(RegularTask)
            case importantTask(ImportantTask)
        }
        
        struct Section {
            var title: String
            var tasks: [Task]
        }
        
        let sections: [Section]
    }
}
