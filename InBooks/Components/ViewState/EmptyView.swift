//
//  EmptyView.swift
//  InBooks
//
//  Created by Matheus Lenke on 12/05/22.
//

import UIKit

class EmptyView: UIView {
    
    // MARK: UI Elements
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var emptyTextLabel: UILabel = {
       let label = UILabel()
        label.text = "Erro"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var emptyImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "book.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Functions
    
    private func addElements() {
        self.backgroundColor = .brown
        self.addSubview(stackView)
        stackView.addArrangedSubview(emptyImageView)
        stackView.addArrangedSubview(emptyTextLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 250),
            emptyImageView.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    // MARK: Public Functions
    
    public func setupEmptyText(with string: String) {
        self.emptyTextLabel.text = string
    }
}
