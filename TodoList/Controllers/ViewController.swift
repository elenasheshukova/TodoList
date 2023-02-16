//
//  ViewController.swift
//  TodoList
//
//  Created by Елена Червоткина on 12.02.2023.
//

import UIKit

class ViewController: UIViewController {
	private var groupedTaskManager: IGroupedTaskManagerAdapter!
	
	@IBOutlet weak var tasksTable: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		setupUI()
	}
	
	private func setup() {
		let taskManager: ITaskManager = SortedTaskManagerDecorator(taskManager: TaskManager())
		let repository: ITaskRepository = MockTaskRepository()
		taskManager.addTasks(repository.getList())
		
		groupedTaskManager = GroupedTaskManagerAdapter(taskManager: taskManager)
	}
	
	private func setupUI() {
		tasksTable.register(TaskTableViewCell.nib(), forCellReuseIdentifier: TaskTableViewCell.identifier)
		tasksTable.dataSource = self
	}
}

extension ViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		groupedTaskManager.getSectionsTitles().count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		groupedTaskManager.getSectionsTitles()[section]
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		groupedTaskManager.getTasksForSections(sectionIndex: section).count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tasksTable.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
		cell.delegate = self
		cell.configure(task: groupedTaskManager.getTasksForSections(sectionIndex: indexPath.section)[indexPath.row])
		return cell
	}
}

extension ViewController: ITaskTableViewCell {
	func changeStatus(task: Task, status: Status) {
		task.status = status
		tasksTable.reloadData()
	}
}

