//
//  TaskTableViewCell.swift
//  TodoList
//
//  Created by Елена Червоткина on 12.02.2023.
//

import UIKit

protocol ITaskTableViewCell {
	func changeStatus(taskId: UUID, status: Status)
}

final class TaskTableViewCell: UITableViewCell {
	
	static let identifier = "TaskTableViewCell"
	
	static func nib() -> UINib {
		return UINib(nibName: "TaskTableViewCell", bundle: nil)
	}
	
	var delegate: ITaskTableViewCell?
	private var task: TaskListModels.ViewModel.Task?
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var statusButton: UIButton!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		let checkedImage = UIImage(systemName: "circle.fill")!
		let uncheckedImage = UIImage(systemName: "circle")!
		statusButton.setImage(checkedImage, for: UIControl.State.selected)
		statusButton.setImage(uncheckedImage, for: UIControl.State.normal)
		prepareForReuse()
	}
	
	override func prepareForReuse() {
		task = nil
		nameLabel.textColor = .black
		dateLabel.text = ""
		backgroundColor = .clear
	}
	
	func configure(task: TaskListModels.ViewModel.Task){
		self.task = task
		
		switch task {
		case .regularTask(let regularTask):
			nameLabel.text = regularTask.title
			statusButton.isSelected = regularTask.status == .completed
		case .importantTask(let importantTask):
			nameLabel.text = importantTask.title
			statusButton.isSelected = importantTask.status == .completed
			dateLabel.text = importantTask.date
			backgroundColor = importantTask.isOverdue ? .systemPink.withAlphaComponent(0.2) : .white
			switch importantTask.priority {
			case .high:
				nameLabel.textColor = .red
			case .medium:
				nameLabel.textColor = .orange
			case .low:
				nameLabel.textColor = .green
			}
		}
	}
	
	@IBAction func changeStatus(_ sender: UIButton) {
		guard let task = task else { return }
		switch task {
		case .regularTask(let regularTask):
			delegate?.changeStatus(taskId: regularTask.id, status: !statusButton.isSelected ? .completed : .notCompleted)
		case .importantTask(let importantTask):
			delegate?.changeStatus(taskId: importantTask.id, status: !statusButton.isSelected ? .completed : .notCompleted)
		}
	}
}
