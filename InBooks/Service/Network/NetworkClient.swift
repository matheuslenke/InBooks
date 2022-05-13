//
//  NetworkClient.swift
//  InBooks
//
//  Created by Matheus Lenke on 13/05/22.
//

import UIKit

public enum ApiError: Error {
    case requestFailed(Error)
    case error(String)
}

protocol NetworkClientProtocol {
    func performRequest(with request: URLRequest, completion: @escaping (Result<Data, ApiError>) -> Void)
}

final class NetworkClient: NetworkClientProtocol {
    func performRequest(with request: URLRequest, completion: @escaping (Result<Data, ApiError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.error("No data")))
                return
            }
        
            completion(.success(data))
            
        }
        task.resume()
    }

}
