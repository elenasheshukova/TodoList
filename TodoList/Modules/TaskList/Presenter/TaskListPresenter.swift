//
//  TaskListPresenter.swift
//  TodoList
//
//  Created by Елена Червоткина on 19.02.2023.
//

import Foundation

protocol ITaskListPresenter {
	init(view: ITaskListView, taskManager: ITaskManager)
	
	/// Показать список задач
	func showTaskList()
	
	/// Изменить статус задачи
	/// - Parameters:
	///   - taskId: идентификатор задачи
	///   - status: новый статус
	func changeTaskStatus(taskId: UUID, status: Status)
}

final class TaskListPresenter : ITaskListPresenter {
	private weak var view: ITaskListView?
	private var groupedTaskManager: IGroupedTaskManagerAdapter!
	
	required init(view: ITaskListView, taskManager: ITaskManager) {
		self.view = view
		
		let taskManager: ITaskManager = OrderedTaskManager(taskManager: taskManager)
		let repository: ITaskRepository = MockTaskRepository()
		taskManager.addTasks(repository.getList())
		
		groupedTaskManager = GroupedTaskManagerAdapter(taskManager: taskManager)
	}
	
	func showTaskList() {
		let viewData: TaskListViewData = .init()
		groupedTaskManager.getSectionsTitles().forEach { title in
			let tasks = groupedTaskManager.getTasksForSections(title: title)
			viewData.sections.append(TaskSection(title: title, tasks: tasks))
		}
		view?.render(viewData: viewData)
	}
	
	func changeTaskStatus(taskId: UUID, status: Status) {
		groupedTaskManager.getTasksForSections(title: nil).first{ $0.id == taskId}?.status = status
		showTaskList()
	}
}
