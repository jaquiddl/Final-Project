//
//  ProfileViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 09/09/24.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var isShowingSettings: Bool = false
    @Published var darkMode: Bool = false 
    @Published var readingBook: BookItem?
    @Published var currentReading: String?
    @Published var alertItem: AlertItem?
    @Published var booksReadCount: Int = 0
    @Published var booksToReadCount: Int = 0
    
    private var booksManager = BooksManager.shared
    
    func getBooksIDs() {
        // Fetch book IDs for each category
        let dispatchGroup = DispatchGroup()
        
        var readingBooks: [String: ReadingData] = [:]
        
        dispatchGroup.enter()
        booksManager.fetchReadingProgress() { [weak self ] readingProgress in
            DispatchQueue.main.async {
                if let readingProgress = readingProgress {
                    readingBooks = readingProgress
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        booksManager.fetchBooksIDs(from: "read") { [weak self] bookIDs in
            DispatchQueue.main.async {
                self?.booksReadCount = bookIDs.count
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        booksManager.fetchBooksIDs(from: "toRead") { [weak self] bookIDs in
            DispatchQueue.main.async {
                self?.booksToReadCount = bookIDs.count
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            
            let sortedReadingBooks = readingBooks.sorted {
                $0.value.lastUpdate > $1.value.lastUpdate // Compare dates
            }
            if let latestBook = sortedReadingBooks.first {
                self.getReadingBook(bookID: latestBook.key)
            }
        }
    }
    

    
    func getReadingBook(bookID: String) {
        Task {
            do {
                let fetchedBook = try await NetworkManager.shared.getBookByID(bookID: bookID)
                DispatchQueue.main.async {
                    self.readingBook = fetchedBook
                    print(self.readingBook?.volumeInfo.title)
                    self.updateCurrentReading()
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
    func updateCurrentReading() {
        
        guard let bookTitle = readingBook?.volumeInfo.title else {
            currentReading = "No current reading"
            return
        }
        // Sort the reading books by timestamp and update currentReading with the latest one
        currentReading = bookTitle
    }
    
}
