//
//  DataService.swift
//  DBZApp
//  Generic data service
//  Created by Uri on 5/9/24.
//

import Foundation

enum RemoteDataSourceError: Error {
    case invalidURL
    case badServerResponse
}

final class DataService {
    
    func fetch<T: Decodable>(type: T.Type, url: URL?) async throws -> T {
        
        // check if url exists
        guard let url = url else {
            throw RemoteDataSourceError.invalidURL
        }
        
        // obtain data & response from url
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // check if response returns 200
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // decode data into our model object
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
}
