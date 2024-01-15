//
//  UserController.swift
//  CoreDataApp
//
//  Created by Dinmukhammed Begaly on 14.01.2024.
//

import UIKit

class UserController: UIViewController {

    private var userView = UserView()
    public var person: Person?
    override func loadView() {
       super.loadView()
        view = userView

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }

    private func setupViews() {
        userView.configureTextFields(data: person?.name ?? "None")
        userView.addButtonTarget(self, action: #selector(changeButtonText))

    }
    
    @objc func changeButtonText() {
        print("pressed")
        if !userView.editTextFieldToggle {
            userView.setButtonText(text: "Save")
            userView.editTextFieldToggle = true
        } else {
            userView.setButtonText(text: "Edit")
            userView.editTextFieldToggle = false
        }
  }
}
