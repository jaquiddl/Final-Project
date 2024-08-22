//
//  SearchViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 22/07/24.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    @Published var books: [BookItem] = []
    @Published var alertItem: AlertItem?
    @Published var searchTerm: String = ""
    @Published var selectedBook: BookItem?
    @Published var isSelected = false
    private var delayTask: DispatchWorkItem?
  
    func getBooksWithDelay(query: String, delay: TimeInterval) {
        
        delayTask?.cancel()
        
        delayTask = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            Task {
                do {
                    print("fetching books")
                    let fetchedBooks = try await NetworkManager.shared.getBooks(query: query)
                    DispatchQueue.main.async {
                        self.books = fetchedBooks
                        print(self.books)
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
        if let delayTask = delayTask {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: delayTask)
        }
    }
            
            
    
    var filteredBooks: [BookItem] {
        if (searchTerm.count >= 3) {
            return books.filter {
                $0.volumeInfo.title.localizedCaseInsensitiveContains(searchTerm) ||
                ($0.volumeInfo.authors?.joined(separator: ", ").localizedCaseInsensitiveContains(searchTerm) ?? false)
            }
        } else {
            return []
        }
    }
}

 
