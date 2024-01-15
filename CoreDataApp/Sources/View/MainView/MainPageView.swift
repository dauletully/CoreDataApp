//
//  MainPageView.swift
//  CoreDataApp
//
//  Created by Dinmukhammed Begaly on 14.01.2024.
//

import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func setGreeting(person: People)
}

class MainPageView: UIView {

    weak var delegate: MainViewDelegate?

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "Enter text"

        return textField
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Press", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)

        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.rowHeight = 40
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        textField.borderStyle = .roundedRect
        button.layer.cornerRadius = 7
    }

    private func setupUI() {
        addSubview(textField)
        addSubview(button)
        addSubview(tableView)
    }

    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }

        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(40)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
    }

}

extension MainPageView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableViewCell else {return UITableViewCell()}
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.setGreeting(person: People.init(name: "", birthday: "", gender: ""))
    }

}
