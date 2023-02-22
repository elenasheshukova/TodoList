//
//  AuthViewController.swift
//  TodoList
//
//  Created by Елена Червоткина on 22.02.2023.
//

import UIKit

protocol IAuthViewController: AnyObject {
	func render(viewModel: AuthModels.ViewModel)
}

class AuthViewController: UIViewController {
	private var interactor: IAuthInteractor?
	
	@IBOutlet weak var textFieldLogin: UITextField!
	@IBOutlet weak var textFieldPass: UITextField!
	@IBAction func buttonLogin(_ sender: Any) {
		if let email = textFieldLogin.text, let password = textFieldPass.text {
			let request = AuthModels.Request(login: email, password: password)
			interactor?.login(request: request)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		assembly()
	}
	
	func assembly() {
		let worker = AuthWorker()
		let presenter = AuthPresenter(view: self)
		interactor = AuthInteractor(worker: worker, presenter: presenter)
	}

}

extension AuthViewController: IAuthViewController {
	func render(viewModel: AuthModels.ViewModel) {
		if viewModel.success {
			MainRouter.navigateToTodoList(source: self)
		} else {
			let alert: UIAlertController = UIAlertController(
				title: "Error",
				message: "",
				preferredStyle: UIAlertController.Style.alert
			)
			let action = UIAlertAction(title: "Ok", style: .default)
			alert.addAction(action)
			present(alert, animated: true, completion: nil)
		}
	}
}
