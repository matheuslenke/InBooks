//
//  ErrorView.swift
//  InBooks
//
//  Created by Matheus Lenke on 12/05/22.
//

import UIKit

class ErrorView: UIView {

    // MARK: UI Elements
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var errorTextLabel: UILabel = {
       let label = UILabel()
        label.text = "Erro"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var errorImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "exclamationmark.icloud.fill")
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
        stackView.addArrangedSubview(errorImageView)
        stackView.addArrangedSubview(errorTextLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 250),
            errorImageView.heightAnchor.constraint(equalToConstant: 70),
        
        ])
    }
    
    // MARK: Public Functions
    
    public func setupErrorText(with string: String) {
        self.errorTextLabel.text = string
    }

}
