//
//  ReadingViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 17/09/24.
//

import SwiftUI

final class ReadingViewModel: ObservableObject {
    @Published var currentPages: [Int] = []
    @Published var readingBooksItems: [BookItem] = []
    @Published var alertItem: AlertItem?
    @Published var isShowingDetails: Bool = false
    @Published var readingProgress: [String: ReadingData] = [:]
    
    @Published var selectedBook: BookItem?
    
    @Published var progress: String = ""
    @Published var currentPage: Int = 0
    
    var percentage: Double {
        guard let totalPages = selectedBook?.volumeInfo.pageCount, totalPages > 0 else {
            return 0.0 // Return 0% if no page count is available
        }
        print(selectedBook)
        print(currentPage)
        print(totalPages)
        return (Double(currentPage) / Double(totalPages)) * 100
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
    
    
    func getReadingBooks() {
        
        BooksManager.shared.fetchReadingProgress() { readingProgress in
            if let readingProgress = readingProgress {
                self.readingProgress = readingProgress
                
                
//                self.currentPage = readingBooksDictionary
                
 
                let sortedReadingBooks = readingProgress.sorted {
                    $0.value.lastUpdate > $1.value.lastUpdate // Compare dates
                    
                }
                let currentPages = sortedReadingBooks.map(\.value.currentPage)
                self.currentPages = currentPages
                let booksIDs = Array(sortedReadingBooks.map {$0.key })
                self.fetchReadingBooks(from: booksIDs)
                print("Current Pages: \(self.currentPages)")
            }
            
        }
        
    }
    
    func fetchReadingBooks(from booksIDs: [String]) {
        Task {
            do {
                let fetchedBooks = try await NetworkManager.shared.getBooksByIDs(bookIDs: booksIDs)
                DispatchQueue.main.async {
                    let sortedBooks = booksIDs.compactMap { id in
                        fetchedBooks.first { book in
                            book.id == id
                        }
                    }
                    self.readingBooksItems = sortedBooks
                    print(self.readingBooksItems)
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
