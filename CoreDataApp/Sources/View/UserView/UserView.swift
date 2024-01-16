//
//  DetailView.swift
//  CoreDataApp
//
//  Created by Dinmukhammed Begaly on 14.01.2024.
//

import UIKit
import SnapKit

class UserView: UIView {

    private var editTextFieldToggle: Bool = false
    private var currentPerson: Person?

    //MARK: - UI elements

    private lazy var button: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(saveEditButton), for: .touchUpInside)

        return button
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "Image")
        imageView.maskCircle(anyImage: image ?? UIImage())

        return imageView
    }()

    private lazy var textFieldName: UITextField = {
        var textField = UITextField()
        textField.setLeftIcon(UIImage(systemName: "person.fill") ?? UIImage())
        textField.font = .systemFont(ofSize: 20)
        textField.isUserInteractionEnabled = false

        return  textField
    }()

    private lazy var textFieldGender: UITextField = {
        var textField = UITextField()
        textField.setLeftIcon(UIImage(systemName: "person.2.fill") ?? UIImage())
        textField.font = .systemFont(ofSize: 20)
        textField.isUserInteractionEnabled = false

        return  textField
    }()

    //MARK: - Life cycle UI
    override func layoutSubviews() {
        super.layoutSubviews()
        button.layer.cornerRadius = 7
        button.layer.borderColor = UIColor.black.cgColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions
    @objc public func saveEditButton() {
        let updatedingName = textFieldName.text
        let updateingGender = textFieldGender.text

        if !editTextFieldToggle {
            button.setTitle("Save", for: .normal)
            editTextFieldToggle = true
            textFieldName.isUserInteractionEnabled = true
            textFieldGender.isUserInteractionEnabled = true
        } else {
            button.setTitle("Edit", for: .normal)
            editTextFieldToggle = false
            textFieldName.isUserInteractionEnabled = false
            textFieldGender.isUserInteractionEnabled = false
            CoreDataManager.shared.updateData(newName:updatedingName ?? "", gender: updateingGender ?? "",currentUser: currentPerson)
            
        }
    }

    public func configureTextFields(data: Person?) {
        currentPerson = data
        self.textFieldName.text = data?.name
        if data?.gender != nil {
            self.textFieldGender.text = data?.gender
        } else {
            self.textFieldGender.placeholder = "Choose your gender"
        }
    }

    //MARK: - Setup
    private func setupUI() {
        addSubview(button)
        addSubview(imageView)
        addSubview(textFieldName)
        addSubview(textFieldGender)
    }

    private func setupConstraints() {

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }

        textFieldName.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }

        textFieldGender.snp.makeConstraints { make in
            make.top.equalTo(textFieldName.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(textFieldGender.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(90)
        }
    }
}
//MARK: - Extensions
extension UIImageView {

    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.image = anyImage
    }
}
extension UITextField {
    func setLeftIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
