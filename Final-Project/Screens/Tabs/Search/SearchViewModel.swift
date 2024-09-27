//
//  SearchViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 22/07/24.
//

import SwiftUI


final class SearchViewModel: ObservableObject {
    @Published var books: [BookItem] = []
    @Published var alertItem: AlertItem?
    @Published var searchTerm: String = ""
    @Published var selectedBook: BookItem?
    @Published var isShowingDetails: Bool = false
    @Published var readingProgress: ReadingData?
    @Published var progress: String = ""
    @Published var currentPage: Int = 0
    
    private var delayTask: DispatchWorkItem?
    
    var percentage: Double {
        guard let totalPages = selectedBook?.volumeInfo.pageCount, totalPages > 0 else {
            return 0.0 // Return 0% if no page count is available
        }
        print(selectedBook)
        print(currentPage)
        print(totalPages)
        return (Double(currentPage) / Double(totalPages)) * 100
    }
    
    func getReadingBooks() {
        
        if let selectedBookID = self.selectedBook?.id {
            BooksManager.shared.fetchSingleReadignProgress(for: selectedBookID) { readingProgress in
                if let readingProgress = readingProgress {
                    
                    let currentPage = readingProgress.currentPage
                    self.currentPage = currentPage
                }
            }
        }
    }
  
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
    func updateProgress() {
        // Safely unwrap selectedBook?.id
        if let bookId = selectedBook?.id {
            // Try to convert progress (String) to Int
            if let currentPage = Int(progress) {
                // Pass the converted Int to updateReadingProgress
                self.currentPage = currentPage
                BooksManager.shared.updateReadingProgress(for: bookId, currentPage: currentPage)
            } else {
                // Handle the case where the conversion fails (e.g., invalid input)
                print("Invalid progress value: \(progress)")
            }
        } else {
            // Handle the case where selectedBook or its id is nil
            print("selectedBook or bookId is nil")
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

 
