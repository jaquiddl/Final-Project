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
    
    func getToReadBooksIDs() {
        BooksManager.shared.fetchBooksWithTimestamps(from: "toRead") { [ weak self ] bookTimestamp in
            guard let self = self else { return }
        let sortedBooksIDs = bookTimestamp
                .sorted(by: { $0.value > $1.value })
                .map( { $0.key })
            self.getToReadBooks(from: sortedBooksIDs)
        }
    }
    
    func getToReadBooks(from booksIDs: [String]) {
        
        Task {
            do {
                let fetchedBooks = try await NetworkManager.shared.getBooksByIDs(bookIDs: booksIDs)
                DispatchQueue.main.async {
                    let sortedBooks = booksIDs.compactMap { id in
                        fetchedBooks.first { book in
                            book.id == id
                        }
                    }
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
