//
//  ToReadViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 09/09/24.
//

import SwiftUI

final class ToReadViewModel: ObservableObject {
    @Published var toReadBooks: [BookItem] = []
    @Published var alertItem: AlertItem?
    @Published var isSelected: Bool = false
    
    private var booksManager = BooksManager.shared
    
    func getToReadBooksIDs() {
        booksManager.fetchBooksIDs(from: "toRead") { [weak self] bookIDs in
            guard let self = self else { return }
            self.getToReadBooks(booksIDs: bookIDs)
        }
    }
    
    func getToReadBooks(booksIDs: [String]) {
        
        Task {
            do {
                let fetchedBooks = try await NetworkManager.shared.getBooksByIDs(bookIDs: booksIDs)
                DispatchQueue.main.async {
                    self.toReadBooks = fetchedBooks
                }
               
            }  catch {
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
