//
//  UserController.swift
//  CoreDataApp
//
//  Created by Dinmukhammed Begaly on 14.01.2024.
//

import UIKit

class UserController: UIViewController {

    //MARK: - Info elements
    public var userInfo: Person?
    private var userView = UserView()

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
        userView.configureTextFields(data: userInfo)
    }


}
