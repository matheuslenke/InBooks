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
    
    let session = URLSession.shared
    
    func fetchSearchBooksBy(title: String, _ handler: @escaping Completion) {
        session.configuration.waitsForConnectivity = false
        
        let request: Request = .searchBooksByTitle(title: title, page: 1, order: "asc")
        
        if var baseUrl = URLComponents(string: request.baseURL) {
            baseUrl.queryItems = request.queryParams
            
            guard let url = baseUrl.url else { return }
            
            var requestUrl = URLRequest(url: url.appendingPathComponent(request.path))
            requestUrl.httpMethod = request.method.name
            
            let dataTask = session.dataTask(with: requestUrl) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else {
                    handler(.failure(.error("No response")))
                    self.session.invalidateAndCancel()
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    do {
                        guard let jsonData = data else {
                            return handler(.failure(.noProcessData))
                        }
                        
                        let decoder = JSONDecoder()
                        let responseData = try decoder.decode(ApiSearchBooksResponse.self, from: jsonData)
                        
                        handler(.success(responseData))
                    } catch (let error) {
                        print("Parser error: \(error)")
                        handler(.failure(.error(error.localizedDescription)))
                    }
                } else {
                    handler(.failure(.urlInvalid))
                }
                
            }
            dataTask.resume()
        }
    }
    
    
    
    
}
