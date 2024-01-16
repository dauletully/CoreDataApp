//
//  MainPageView.swift
//  CoreDataApp
//
//  Created by Dinmukhammed Begaly on 14.01.2024.
//

import UIKit
import SnapKit
import CoreData

protocol MainViewDelegate: AnyObject {
    func setGreeting(person: Person)
}

class MainPageView: UIView {

    weak var delegate: MainViewDelegate?
    private lazy var person: [Person] = []
    
    //MARK: - UI elements
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
        button.addTarget(self, action: #selector(addButton), for: .touchUpInside)

        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 40
        tableView.layer.cornerRadius = 6.0
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    //MARK: - Life style App
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        tableView.reloadData()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        textField.borderStyle = .roundedRect
        button.layer.cornerRadius = 7
    }

    public func configure(person: [Person]) {
        self.person = person
    }

    @objc public func addButton() {
        guard let addingName = self.textField.text else { return }
        CoreDataManager.shared.saveData(currentName: addingName)
        self.person = CoreDataManager.shared.fetchData()
        self.tableView.reloadData()
        self.textField.text = ""
    }
    //MARK: - setup
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {return UITableViewCell()}
        cell.configure(name: person[indexPath.row].name ?? "")
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentUser = person[indexPath.row]
        delegate?.setGreeting(person: currentUser)

    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            CoreDataManager.shared.deleteData(userEntity: person[indexPath.row])
            person.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            tableView.reloadData()
        }
    }

}
