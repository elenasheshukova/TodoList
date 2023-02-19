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

class TaskTableViewCell: UITableViewCell {
	
	static let identifier = "TaskTableViewCell"
	
	static func nib() -> UINib {
		return UINib(nibName: "TaskTableViewCell", bundle: nil)
	}
	
	var delegate: ITaskTableViewCell?
	private weak var task: Task?
	
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
	
	func configure(task: Task){
		self.task = task
		
		nameLabel.text = task.title
		statusButton.isSelected = task.status == .completed
		
		if let importantTask = task as? ImportantTask {
			let formatter = DateFormatter()
			formatter.dateStyle = .medium
			dateLabel.text = formatter.string(from: importantTask.date)
			
			if importantTask.date < Date() && importantTask.status != .completed {
				backgroundColor = .systemPink.withAlphaComponent(0.2)
			}
			
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
        
        delegate?.changeStatus(taskId: task.id, status: !statusButton.isSelected ? .completed : .notCompleted)
	}
}
