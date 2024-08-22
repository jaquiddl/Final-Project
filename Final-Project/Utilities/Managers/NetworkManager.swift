//
//  NetworkManager.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 22/07/24.
//

import SwiftUI


final class NetworkManager {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    
    static let baseURL = "https://www.googleapis.com/books/v1/volumes"
    static let apiKey = "AIzaSyAe3BojgxNyW8UGeCNlXQ9AVt1E6tXzBgQ"
    
    private init () {}
    
    func getBooks(query: String) async throws -> [BookItem] {
        guard var components = URLComponents(string: NetworkManager.baseURL) else {
            throw BookError.invalidURL
        }
        
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "filter", value: "paid-ebooks"),
            URLQueryItem(name: "langRestrict", value: "en, es"),
            URLQueryItem(name: "printType", value: "books"),
            URLQueryItem(name: "orderBy", value: "relevance"),
            URLQueryItem(name: "key", value: NetworkManager.apiKey)
        ]
        
        guard let url = components.url else {
            throw BookError.invalidURL
        }
        print("Making request to URL: \(url)")
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Invalid response from server")
            throw BookError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            print("data decoded")
            return try decoder.decode(BooksResponse.self, from: data).items
            
        } catch {
            print("Error decoding JSON: \(error)")
            throw BookError.invalidData
        }
    }
    
    
    
//    func getBooks() -> [BookItem]{
//        return MockData.mockBooks
//    }
    
}
