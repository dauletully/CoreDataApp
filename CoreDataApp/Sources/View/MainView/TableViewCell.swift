
import UIKit
import SnapKit


class TableViewCell: UITableViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    public func configure(name: String) {
        self.label.text = name
        
    }

    private func setupUI() {
        contentView.addSubview(label)
    }

    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
        }
    }

}
