//
//  BookDetailsViewController.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import UIKit

class BookDetailsViewController: UIViewController {
    
    var viewModel: BookDetailsViewModel?
    
    lazy var bookDetailsView: BookDetailsView = {
        let bookDetails = BookDetailsView()
        return bookDetails
    }()
    
    override func loadView() {
        view = bookDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    private func configUI() {
        title = "Detalhes"
        bookDetailsView.delegateTableView(delegate: self, dataSource: self)
    
        if let viewModel = viewModel {
            bookDetailsView.setupDetails(book: viewModel.book)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addBookToLibrary))
    }
    
    @objc func addBookToLibrary() {
        if let viewModel = viewModel {
            if viewModel.book.imagens.count > 0 {
                let imgUrl = viewModel.book.imagens[0].imagemPrimeiraCapa?.media
                ManagedObjectContext.shared.save(book: SimpleBook(title: viewModel.book.titulo , coverUrl: imgUrl)) { _ in
                    self.displayAlert(titulo: "Sucesso!", mensagem: "Livro adicionado à sua biblioteca")
                    return
                }
            }
        }
        self.displayAlert(titulo: "Error", mensagem: "Erro ao adicionar livro")
    }
}

extension BookDetailsViewController: UITableViewDelegate {
 
}

extension BookDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.descriptionElements.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextDescriptionTableViewCell.classIdentifier()) as? TextDescriptionTableViewCell else { return UITableViewCell()}
        if let elements = viewModel?.descriptionElements[indexPath.row] {
            cell.configCell(with: elements)
        }
        return cell
    }
    
    
}
