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
    
    private var booksManager = BooksManager.shared
    
    @MainActor
    
    
    func getReadBooksIDs() {
        booksManager.fetchBooksIDs(from: "read") { [weak self] bookIDs in
            guard let self = self else { return }
            self.getReadBooks(bookIDs: bookIDs)  // Pass the bookIDs parameter correctly
        }
    }
    
    func getReadBooks(bookIDs: [String]) {
        
        Task {
            do {
                let fetchedBooks = try await NetworkManager.shared.getBooksByIDs(bookIDs: bookIDs)
                DispatchQueue.main.async {
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

