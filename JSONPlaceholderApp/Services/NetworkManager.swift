//
//  NetworkManager.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    private init() {}
    
    func fetch<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: "\(baseURL)/\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
#if DEBUG
        print("📡 Request: \(url.absoluteString)")
#endif
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
#if DEBUG
        print("📡 Response: \(httpResponse.statusCode) for \(url.absoluteString)")
#endif
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
}
