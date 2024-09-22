//
//  ReadViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 04/09/24.
//

import SwiftUI
import Combine


final class ReadViewModel: ObservableObject {
    @Published var readBooks: [BookItem] = []
    @Published var alertItem: AlertItem?
    @Published var isSelected: Bool = false
    
    
    
    @MainActor
    
    
    func getReadBooksIDs() {
        BooksManager.shared.fetchBooksWithTimestamps(from: "read") { [weak self] bookTimestamp in
            guard let self = self else { return }
            let sortedBooksIDs = bookTimestamp
                .sorted(by: {$0.value > $1.value })
                .map { $0.key }
            self.getReadBooks(from: sortedBooksIDs)
        }
    }
    
    func getReadBooks(from bookIDs: [String]) {
        
        Task {
            do {
                let fetchedBooks = try await NetworkManager.shared.getBooksByIDs(bookIDs: bookIDs)
                DispatchQueue.main.async {
                    let sortedBooks = bookIDs.compactMap { id in
                        fetchedBooks.first { book in
                            book.id == id
                        }
                    }
                    
                    self.readBooks = fetchedBooks
                }
            } catch {
                DispatchQueue.main.async {
                    if let bookError = error as? BookError {
                        switch bookError {
                        case .invalidURL:
                            self.alertItem = alertContext.invalidURL
                        case .invalidResponse:
                            self.alertItem = alertContext.invalidResponse
                        case .invalidData:
                            self.alertItem = alertContext.invalidData
                        case .unableToComplete:
                            self.alertItem = alertContext.unableToComplete
                        }
                    } else {
                        self.alertItem = alertContext.genericError
                    }
                }
            }
        }
        
    }
}

