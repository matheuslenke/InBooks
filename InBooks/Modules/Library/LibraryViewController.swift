//
//  FavoritesViewController.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import UIKit

protocol LibraryManagerDelegate: AnyObject {
    func fetchBooksWithSuccess()
    func errorToFetchBooks(_ error: String)
}

class LibraryViewController: MultiStateViewController {
    
    var viewModel: LibraryViewModel?
    
    // MARK: Private Variables
    
    private var state: ViewState = .loading {
        didSet {
            DispatchQueue.main.async {
                self.setupView()
            }
        }
    }

    private func setupView() {
        switch state {
        case .loading:
            self.setupLoadingState()
        case .normal:
            self.setupNormalState()
        case .error:
            self.setupErrorState(message: "Erro ao encontrar livros. Por favor, tente novamente")
        case .empty:
            self.setupEmptyState(message: "Sua biblioteca está vazia! Adicione novos livros")
        }
    }
    
    // MARK: UI Elements
    
    lazy var libraryView: LibraryView = {
        let library = LibraryView()
        library.translatesAutoresizingMaskIntoConstraints = false
        return library
    }()
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchBooks()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchBooks()
        
        title = "My Library"
        configLibraryView()
    }
    
    // MARK: Private functions
    
    private func configLibraryView() {
        libraryView.setupCollectionViewDelegates(delegate: self, dataSource: self)
        self.contentView.addSubview(libraryView)
        
        NSLayoutConstraint.activate([
            libraryView.topAnchor.constraint(equalTo: contentView.topAnchor),
            libraryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            libraryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            libraryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func fetchBooks() {
        if let viewModel = viewModel {
            state = .loading
            viewModel.fetchBooks()
            libraryView.reloadCollectionView()
        }
    }
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width * 0.45
        return CGSize(width: width, height: width * 1.5 + 22.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

extension LibraryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = viewModel?.books[indexPath.item] else { return }
        
        displayDeletionAlert(item: item)
    }
    
    private func displayDeletionAlert(item: SimpleBook) {
        let ac = UIAlertController(title: "Atenção", message: "Deseja deletar este livro de sua biblioteca?", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Deletar", style: .destructive) { [weak self] _ in
            ManagedObjectContext.shared.delete(title: item.title) { _ in
                self?.viewModel?.deleteBook(book: item)
                self?.fetchBooks()
            }
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel)
        ac.addAction(confirm)
        ac.addAction(cancel)
        self.present(ac, animated: true)
    }
}

extension LibraryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
        
        if let book = viewModel?.books[indexPath.row] {
            cell.setupCell(with: book)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.books.count ?? 0
    }
}

extension LibraryViewController: LibraryManagerDelegate {
    func fetchBooksWithSuccess() {
        if let viewModel = viewModel {
            if viewModel.books.count == 0 {
                state = .empty
            } else {
                state = .normal
            }
        }
    }
    
    func errorToFetchBooks(_ error: String) {
        state = .error
        print(error)
        self.displayAlert(titulo: "Error", mensagem: error)
    }
}

