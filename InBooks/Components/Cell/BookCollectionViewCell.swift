//
//  BookCollectionViewCell.swift
//  InBooks
//
//  Created by Matheus Lenke on 12/05/22.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var bookCover: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "text.book.closed.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(bookCover)
        stackView.addArrangedSubview(title)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            title.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    public func setupCell(with book: SimpleBook) {
        if let img = book.coverUrl, let url = URL(string: img) {
            bookCover.kf.setImage(with: url)
        }
        title.text = book.title
    }
    
}
