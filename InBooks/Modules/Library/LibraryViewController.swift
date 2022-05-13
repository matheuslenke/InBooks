//
//  FavoritesViewController.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import UIKit

class LibraryViewController: UIViewController {
    
    var viewModel: LibraryViewModel?
    
    lazy var libraryView: LibraryView = {
        let library = LibraryView()
        return library
    }()
    
    override func loadView() {
        self.view = libraryView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let viewModel = viewModel {
            viewModel.fetchBooks()
            libraryView.reloadCollectionView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel {
            viewModel.fetchBooks()
            libraryView.reloadCollectionView()
        }
        
        title = "My Library"
        configLibraryView()
    }
    
    private func configLibraryView() {
        libraryView.setupCollectionViewDelegates(delegate: self, dataSource: self)
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
                self?.libraryView.reloadCollectionView()
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

