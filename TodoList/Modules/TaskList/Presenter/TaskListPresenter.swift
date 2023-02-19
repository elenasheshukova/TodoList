//
//  TaskListPresenter.swift
//  TodoList
//
//  Created by Елена Червоткина on 19.02.2023.
//

import Foundation

protocol ITaskListPresenter {
    init(view: ITaskListView, taskManager: ITaskManager)
    func showTaskList()
    func changeTaskStatus(taskId: UUID, status: Status)
}

class TaskListPresenter : ITaskListPresenter {
    private let view: ITaskListView
    private var groupedTaskManager: IGroupedTaskManagerAdapter!
    
    required init(view: ITaskListView, taskManager: ITaskManager) {
        self.view = view
        
        let taskManager: ITaskManager = SortedTaskManagerDecorator(taskManager: taskManager)
        let repository: ITaskRepository = MockTaskRepository()
        taskManager.addTasks(repository.getList())
        
        groupedTaskManager = GroupedTaskManagerAdapter(taskManager: taskManager)
    }
    
    func showTaskList() {
        var list: TaskListViewData = .init()
        groupedTaskManager.getSectionsTitles().forEach { title in
            let tasks = groupedTaskManager.getTasksForSections(title: title)
            list.sections.append(TaskSection(title: title, tasks: tasks))
        }
        view.render(viewData: list)
    }
    
    func changeTaskStatus(taskId: UUID, status: Status) {
        groupedTaskManager.getTasksForSections(title: "Незавершенные").first{ $0.id == taskId}?.status = status
        showTaskList()
    }
}
