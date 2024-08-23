//
//  NetworkManager.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 22/07/24.
//

import SwiftUI


final class NetworkManager {
    static let shared = NetworkManager()
    private let diskCache = DiskCache.shared
    
    
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
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Invalid response from server")
            throw BookError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            
            return try decoder.decode(BooksResponse.self, from: data).items
            
        } catch {
            print("Error decoding JSON: \(error)")
            throw BookError.invalidData
        }
    }
    
    func getBookByID(bookID: String) async throws -> BookItem {
        
        if let cachedBook = diskCache.getBook(forKey: bookID) {
            
            return cachedBook
        }
        let urlString = "\(NetworkManager.baseURL)/\(bookID)?key=\(NetworkManager.apiKey)"
        
        guard let url = URL(string: urlString) else {
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
            let book = try decoder.decode(BookItem.self, from: data)
            diskCache.setBook(book, forKey: bookID)
            return book
        } catch {
            print("Error decoding JSON: \(error)")
            throw BookError.invalidData
        }
    }
    
    func getBooksByIDs(bookIDs: [String]) async throws -> [BookItem] {
        var books: [BookItem] = []
        var errors: [Error] = []
        
        // Fetch books concurrently using a task group
        await withTaskGroup(of: Result<BookItem, Error>.self) { group in
            for bookID in bookIDs {
                group.addTask { [self] in // Use explicit 'self' here to capture
                    do {
                        let book = try await self.getBookByID(bookID: bookID) // Explicit 'self'
                        return .success(book)
                    } catch {
                        return .failure(error)
                    }
                }
            }
            
            // Collect the results asynchronously
            for await result in group {
                switch result {
                case .success(let book):
                    books.append(book)
                case .failure(let error):
                    errors.append(error)
                }
            }
        }
        
        // Handle any errors encountered
        if !errors.isEmpty {
            throw errors.first!
        }
        
        return books
    }
    
//    func getBooksByIDs(bookIDs: [String]) async throws -> [BookItem] {
//        let group = DispatchGroup()
//        var books: [BookItem] = []
//    }
    
    
    
//    func getBooks() -> [BookItem]{
//        return MockData.mockBooks
//    }
    
}
