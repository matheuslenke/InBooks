//
//  TextDescriptionTableViewCell.swift
//  InBooks
//
//  Created by Matheus Lenke on 12/05/22.
//

import UIKit

class TextDescriptionTableViewCell: UITableViewCell {
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Descrição"
        label.numberOfLines = 0
        label.textColor = .label
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addElements()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -15),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    // MARK: Public functions
    
    public func configCell(with model: TextDescriptionElement) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
