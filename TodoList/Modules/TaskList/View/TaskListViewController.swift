//
//  ViewController.swift
//  TodoList
//
//  Created by Елена Червоткина on 12.02.2023.
//

import UIKit

protocol ITaskListView: AnyObject {
	/// отобразить список задач
	/// - Parameter viewData: сгруппированный список задач
	func render(viewData: TaskListViewData)
}

final class TaskListViewController: UIViewController {
	private var taskList: TaskListViewData = .init()
	var presenter: ITaskListPresenter!
	
	@IBOutlet weak var tasksTable: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		presenter.showTaskList()
	}
	
	private func setupUI() {
		tasksTable.register(TaskTableViewCell.nib(), forCellReuseIdentifier: TaskTableViewCell.identifier)
		tasksTable.dataSource = self
	}
}

extension TaskListViewController: ITaskListView {
	func render(viewData: TaskListViewData){
		taskList = viewData
		tasksTable.reloadData()
	}
}

extension TaskListViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		taskList.sections.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		taskList.sections[section].title
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		taskList.sections[section].tasks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tasksTable.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
		cell.delegate = self
		cell.configure(task: taskList.sections[indexPath.section].tasks[indexPath.row])
		return cell
	}
}

extension TaskListViewController: ITaskTableViewCell {
	func changeStatus(taskId: UUID, status: Status) {
		presenter.changeTaskStatus(taskId: taskId, status: status)
	}
}
