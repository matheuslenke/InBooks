//
//  BookTableViewCell.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import UIKit
import Kingfisher

class BookTableViewCell: UITableViewCell {

    lazy var bookCoverImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.image = UIImage(systemName: "text.book.closed.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Titulo"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Subtítulo"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookYearLabel: UILabel = {
        let label = UILabel()
        label.text = "2022"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .label
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
    
    func setupView(with model: Book) {
        self.bookTitleLabel.text = model.titulo
        self.bookSubtitleLabel.text = model.subtitulo
        self.bookYearLabel.text = model.anoEdicao
        if model.imagens.count > 0 {
            if let img = model.imagens[0].imagemPrimeiraCapa?.pequena,
               let imageUrl = URL(string: img) {
                self.bookCoverImageView.kf.setImage(with: imageUrl)
            }
        }
    }
    
    private func addElements() {
        self.addSubview(bookCoverImageView)
        self.addSubview(bookYearLabel)
        self.addSubview(bookTitleLabel)
        self.addSubview(bookSubtitleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookCoverImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            bookCoverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bookCoverImageView.heightAnchor.constraint(equalToConstant: 70),
            bookCoverImageView.widthAnchor.constraint(equalToConstant: 60),
            
            bookYearLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bookYearLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            bookYearLabel.widthAnchor.constraint(equalToConstant: 55),
            
            bookTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            bookTitleLabel.leadingAnchor.constraint(equalTo: bookCoverImageView.trailingAnchor, constant: 10),
            bookTitleLabel.trailingAnchor.constraint(equalTo: bookYearLabel.leadingAnchor, constant: -10),
            bookTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            bookSubtitleLabel.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor, constant: 5),
            bookSubtitleLabel.leadingAnchor.constraint(equalTo: bookCoverImageView.trailingAnchor, constant: 10),
            bookSubtitleLabel.trailingAnchor.constraint(equalTo: bookYearLabel.leadingAnchor, constant: -10),
            bookSubtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
