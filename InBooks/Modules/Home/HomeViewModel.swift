//
//  HomeViewModel.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import Foundation

class HomeViewModel {
    // MARK: - Private variables
    
    private var searchBooksService: BooksServiceProtocol
    private var isFetchInProgress = false
    
    // MARK: - Public variables
    weak var delegate: HomeManagerDelegate?
    var searchTitle = ""
    
    var books: [Book] = []
    
    // MARK: - Life Cycle
    
    init(searchBookService: BooksServiceProtocol) {
        self.searchBooksService = searchBookService
    }
    
    // MARK: Public functions
    
    func fetchBooks() {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        searchBooksService.fetchSearchBooksBy(title: searchTitle) { result in
            switch result {
            case .success(let apiResponse):
                self.isFetchInProgress = false
                self.success(apiResponse: apiResponse)
            case .failure(let error):
                self.isFetchInProgress = false
                self.error(error: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: Private functions
    
    private func success(apiResponse: ApiSearchBooksResponse) {
        self.isFetchInProgress = false
        self.books = apiResponse.books ?? []
        delegate?.fetchBooksWithSuccess()
    }
    
    private func error(error: String) {
        print(error)
    }
}
