//
//  HomeViewController.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import UIKit

class HomeViewController: MultiStateViewController {
    
    // MARK: Public variables
    
    var viewModel: HomeViewModel?
    
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
            self.setupErrorState(message: "Erro ao encontrar livros. Por favor, cheque sua conexão e tente novamente")
        case .empty:
            self.setupEmptyState(message: "Nenhum livro encontrado com este termo")
        }
    }

    // MARK: UI Elements
    
    lazy var homeView: HomeView = {
        let homeView = HomeView()
        homeView.translatesAutoresizingMaskIntoConstraints = false
        return homeView
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.searchTitle = "Harry potter"
        state = .loading
        fetchBooks()
        configHomeView()
        configTableView()
        configSearchBar()
    }
    
    // MARK: Private functions
    
    private func configHomeView(){
        self.viewModel?.delegate = self
        self.homeView.delegate(delegate: self)
        self.homeView.delegateSearchBar(delegate: self)
        self.contentView.addSubview(homeView)
        self.title = "Home"
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func configTableView() {
        self.homeView.delegateTableView(delegate: self, dataSource: self)
    }
    
    private func fetchBooks() {
        state = .loading
        self.viewModel?.fetchBooks()
    }

}

// MARK: HomeManagerDelegate

extension HomeViewController: HomeManagerDelegate {
    func fetchBooksWithSuccess() {
        if viewModel?.books.count == 0 {
            state = .empty
        } else {
            state = .normal
            DispatchQueue.main.async {
                self.homeView.reloadTableView()
            }
        }
    }
    
    func errorToFetchBooks(_ error: String) {
        state = .error
        print(error)
    }
}

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.goToBookDetails(bookIndex: indexPath.row)
    }
}

// MARK: UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.books.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.classIdentifier()) as? BookTableViewCell else { return UITableViewCell()}
        
        guard let book = self.viewModel?.books[indexPath.row] else { return UITableViewCell()}
        
        cell.setupView(with: book)
        return cell
    }
    
}

extension HomeViewController: HomeViewProtocol {
    func didSelectBook() {
        
    }
    
    func configSearchBar() {
        self.navigationItem.searchController = homeView.searchController
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.searchTextField.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let bookTitle = searchBar.searchTextField.text {
            viewModel?.searchTitle = bookTitle
//            viewModel?.resetPage()
            fetchBooks()
        }
    }
}
