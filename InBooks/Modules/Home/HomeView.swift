//
//  HomeView.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func didSelectBook()
    func configSearchBar()
}

class HomeView: UIView {
    
    // MARK: Delegates
    
    weak private var delegate: HomeViewProtocol?
    
    public func delegate(delegate: HomeViewProtocol?){
        self.delegate = delegate
    }
    
    // MARK: UI Elements
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsScopeBar = false
        searchController.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .label
        return searchController
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.classIdentifier())
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    public func delegateTableView(delegate:UITableViewDelegate,dataSource:UITableViewDataSource){
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    public func delegateSearchBar(delegate: UISearchBarDelegate) {
        self.searchController.searchBar.delegate = delegate
    }
    
    public func reloadTableView(){
        self.tableView.reloadData()
    }
    
    // MARK: Life Cycle

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        addElements()
        setupConstraints()
    }
    
    // MARK: Private functions
    
    private func addElements() {
        self.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
