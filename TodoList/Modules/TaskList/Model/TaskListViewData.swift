//
//  TaskListViewData.swift
//  TodoList
//
//  Created by Елена Червоткина on 19.02.2023.
//

import Foundation

class TaskListViewData {
    var sections: [TaskSection] = []
}

class TaskSection {
    var title: String
    var tasks: [Task]
    
    init(title: String, tasks: [Task]) {
        self.title = title
        self.tasks = tasks
    }
}
