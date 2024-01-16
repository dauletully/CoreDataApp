//
//  DetailView.swift
//  CoreDataApp
//
//  Created by Dinmukhammed Begaly on 14.01.2024.
//

import UIKit
import SnapKit

class UserView: UIView {

    var editTextFieldToggle: Bool = false
    
    //MARK: - UI elements
    private lazy var button: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 1
        
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
        textField.setLeftIcon(UIImage(systemName: "star") ?? UIImage())
        textField.font = .systemFont(ofSize: 20)
        return  textField
    }()

    private lazy var textFieldGender: UITextField = {
        var textField = UITextField()
        textField.setLeftIcon(UIImage(systemName: "star") ?? UIImage())
        textField.font = .systemFont(ofSize: 20)
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
    public func configureTextFields(data: String) {
        self.textFieldName.text = data
    }
    


    

    //MARK: - Setup
    private func setupUI() {
        addSubview(button)
        addSubview(imageView)
        addSubview(textFieldName)
        addSubview(textFieldGender)
    }

    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(90)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(150)
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
    }


}
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
