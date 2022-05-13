//
//  NetworkClientMock.swift
//  InBooksTests
//
//  Created by Matheus Lenke on 13/05/22.
//

import Foundation
@testable import InBooks

final class NetworkClientMock: NetworkClientProtocol {
    
    func performRequest(with request: URLRequest, completion: @escaping (Result<Data, ApiError>) -> Void) {
        guard let urlFromRequest = request.url else {
            completion(.failure(.error("Error")))
            return
        }
        let resource = self.getResourceName(url: urlFromRequest)
        guard let json = Bundle.main.path(forResource: resource, ofType: "json") else { return }
        let url = URL(fileURLWithPath: json)

        do {
            let newData = try Data(contentsOf: url)
            completion(.success(newData))
        } catch {
            completion(.failure(.requestFailed(error)))
        }
    }
    
    private func getResourceName(url: URL) -> String {
        var resourceName = url.lastPathComponent
        resourceName = resourceName.components(separatedBy: ".")[0]
        return resourceName
    }
}
