//
//  BookDetailsView.swift
//  InBooks
//
//  Created by Matheus Lenke on 12/05/22.
//

import UIKit

class BookDetailsView: UIView {

    lazy var bookCoverImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "text.book.closed.fill")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var bookTitle: UILabel = {
        let label = UILabel()
        label.text = "Título"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookSubTitle: UILabel = {
        let label = UILabel()
        label.text = "Subtítulo"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(TextDescriptionTableViewCell.self, forCellReuseIdentifier: TextDescriptionTableViewCell.classIdentifier())
        return tableView
    }()
    
    lazy var addToLibraryButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Life Cycle
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private functions
    
    private func addElements() {
        self.addSubview(bookCoverImageView)
        self.addSubview(bookTitle)
        self.addSubview(bookSubTitle)
        self.addSubview(tableView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bookCoverImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            bookCoverImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            bookCoverImageView.heightAnchor.constraint(equalToConstant: 150),
            bookCoverImageView.widthAnchor.constraint(equalToConstant: 130),
            
            bookTitle.topAnchor.constraint(equalTo: bookCoverImageView.bottomAnchor, constant: 5),
            bookTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            bookTitle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            bookSubTitle.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 5),
            bookSubTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            bookSubTitle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: bookSubTitle.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: Public functions
    
    public func delegateTableView(delegate:UITableViewDelegate,dataSource:UITableViewDataSource){
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    public func reloadTableView(){
        self.tableView.reloadData()
    }
    
    public func setupDetails(book: Book) {
        bookTitle.text = book.titulo
        bookSubTitle.text = book.subtitulo
        
        guard book.imagens.count > 0 else { return }
        
        if let img = book.imagens[0].imagemPrimeiraCapa?.media {
            if let url = URL(string: img) {
                bookCoverImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "text.book.closed.fill"))
            }
        }
    }
    
}
