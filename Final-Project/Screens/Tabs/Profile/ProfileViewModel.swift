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
        
        var readingBooksWithTimestamps: [String: Date] = [:]
        
        dispatchGroup.enter()
        booksManager.fetchBooksWithTimestamps(from: "reading") { [weak self] bookTimestamps in
            DispatchQueue.main.async {
                readingBooksWithTimestamps = bookTimestamps
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
            
            let sortedReadingBooks = readingBooksWithTimestamps.sorted { $0.value > $1.value }
            if let latestBook = sortedReadingBooks.first {
                self.getReadingBook(bookID: latestBook.key)
            }
        }
    }
    

    
    func getReadingBook(bookID: String) {
        Task {
            do {
                let fetchedBooks = try await NetworkManager.shared.getBookByID(bookID: bookID)
                DispatchQueue.main.async {
                    self.readingBook = fetchedBooks
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
