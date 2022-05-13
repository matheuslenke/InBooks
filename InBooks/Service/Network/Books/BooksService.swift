//
//  BooksService.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import Foundation

internal typealias Completion = (Result<ApiSearchBooksResponse, BooksAPIError>) -> Void

protocol BooksServiceProtocol {
    func fetchSearchBooksBy(title: String, _ handler: @escaping Completion)
}

struct BooksService: BooksServiceProtocol {
    
    let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    let session = URLSession.shared
    
    func fetchSearchBooksBy(title: String, _ handler: @escaping Completion) {
        session.configuration.waitsForConnectivity = false
        
        let request: Request = .searchBooksByTitle(title: title, page: 1)
        
        if var baseUrl = URLComponents(string: request.baseURL) {
            baseUrl.queryItems = request.queryParams
            
            guard let url = baseUrl.url else { return }
            
            var requestUrl = URLRequest(url: url.appendingPathComponent(request.path))
            requestUrl.httpMethod = request.method.name
            
            networkClient.performRequest(with: requestUrl) { result in
                switch result {
                case .success(let data):
                    do {
                        
                        let decoder = JSONDecoder()
                        let responseData = try decoder.decode(ApiSearchBooksResponse.self, from: data)
                        
                        handler(.success(responseData))
                    } catch (let error) {
                        print("Parser error: \(error)")
                        handler(.failure(.error(error.localizedDescription)))
                    }
                case .failure(let error):
                    handler(.failure(.error(error.localizedDescription)))
                }
            }
        }
    }
    
    
    
    
}
