//
//  ViewController.swift
//  TodoList
//
//  Created by Елена Червоткина on 12.02.2023.
//

import UIKit


protocol ITaskListViewController: AnyObject {
	/// отобразить список задач
	/// - Parameter viewModel: сгруппированный список задач
	func render(viewModel: TaskListModels.ViewModel)
}

final class TaskListViewController: UIViewController {
	private var interactor: ITaskListInteractor?
	
	private var taskList: TaskListModels.ViewModel = .init(sections: [])
	
	@IBOutlet weak var tasksTable: UITableView!
	
	init(taskManager: ITaskManager) {
		super.init(nibName: nil, bundle: nil)
		let presenter = TaskListPresenter(view: self)
		self.interactor = TaskListInteractor(presenter: presenter, taskManager: taskManager)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		interactor?.showTaskList()
	}
	
	private func setupUI() {
		tasksTable.register(TaskTableViewCell.nib(), forCellReuseIdentifier: TaskTableViewCell.identifier)
		tasksTable.dataSource = self
	}
}

extension TaskListViewController: ITaskListViewController {
	func render(viewModel: TaskListModels.ViewModel) {
		taskList = viewModel
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
		interactor?.changeTaskStatus(request: TaskListModels.Request.changeTaskStatus(id: taskId, status: status))
	}
}
