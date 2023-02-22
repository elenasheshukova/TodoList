//
//  TaskListInteractor.swift
//  TodoList
//
//  Created by Елена Червоткина on 22.02.2023.
//

import Foundation

protocol ITaskListInteractor {
    func showTaskList()
    func changeTaskStatus(request: TaskListModels.Request.changeTaskStatus)
}

class TaskListInteractor: ITaskListInteractor {
    private var presenter: ITaskListPresenter?
    
    private var groupedTaskManager: IGroupedTaskManagerAdapter!
    
	init(presenter: ITaskListPresenter, taskManager: ITaskManager) {
        self.presenter = presenter
        
        let taskManager: ITaskManager = OrderedTaskManager(taskManager: taskManager)
        let repository: ITaskRepository = MockTaskRepository()
        taskManager.addTasks(repository.getList())
        
        groupedTaskManager = GroupedTaskManagerAdapter(taskManager: taskManager)
    }
    
    func showTaskList() {
        var sections: [TaskListModels.Responce.Section] = []
        groupedTaskManager.getSectionsTitles().forEach { title in
            let section = TaskListModels.Responce.Section(
                title: title,
                tasks: groupedTaskManager.getTasksForSections(title: title)
            )
            sections.append(section)
        }
		presenter?.present(responce: TaskListModels.Responce.init(sections: sections))
    }
    
    func changeTaskStatus(request: TaskListModels.Request.changeTaskStatus) {
        groupedTaskManager.getTasksForSections(title: nil).first{ $0.id == request.id}?.status = request.status
        showTaskList()
    }
}
