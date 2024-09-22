//
//  BooksManager.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 04/09/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class BooksManager {
    static let shared = BooksManager()
    private let db = Firestore.firestore()
    
    private init() {}
    
    private func getUserRef() -> DocumentReference? {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No authenticated user found")
            return nil
        }
        return db.collection("users").document(userID)
    }
    
    func moveBook(from oldCategory: String, to newCategory: String, bookID: String) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No authenticated user found")
            return
        }
        
        let userRef = db.collection("users").document(userID)
        
        // Create a new BookDetails object with the new category
        let bookDetails = BookDetails(category: newCategory, timestamp: Date(), order: nil)
        
        // Fetch the user's current booksDictionary
        userRef.getDocument { [weak self] document, error in
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }
            guard let document = document, document.exists, let data = document.data() else {
                print("User document does not exist or is empty")
                return
            }
            
            // Update Firestore to move the book
            var updates: [String: Any] = [:]
            
            // If the book exists in the old category, remove it
            if let booksDictionary = data["booksDictionary"] as? [String: [String: Any]],
               booksDictionary[bookID] != nil {
                updates["booksDictionary.\(bookID)"] = FieldValue.delete()
            }
            
            // Add or update the book to the new category
            updates["booksDictionary.\(bookID)"] = [
                "category": bookDetails.category,
                "timestamp": bookDetails.timestamp as Any,
                "order": bookDetails.order as Any
            ]
            
            // Perform the update
            userRef.updateData(updates) { error in
                if let error = error {
                    print("Error updating book category: \(error.localizedDescription)")
                } else {
                    print("Book category updated successfully")
                }
            }
            if newCategory == "reading" {
                self?.updateReadingProgress(for: bookID, currentPage: 0)
            }
        }
    }
    
    func updateBookDictionary (to category: String, bookID: String) {
        guard let userRef = getUserRef() else { return }
        
        userRef.getDocument { document, error in
            if let error  = error {
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }
            guard let document = document, document.exists, let data = document.data() else {
                print("User document does not exist")
                return
            }
            if let booksDictionary = data["booksDictionary"] as? [String: [String: Any]],
               let bookDetailsData = booksDictionary[bookID],
                let currentCategory = bookDetailsData["category"] as? String {
                
                if currentCategory == category {
                    print("Book is already in the booksDictionary with the same category. No update needed.")
                    return
                } else {
                    self.moveBook(from: currentCategory, to: category, bookID: bookID)
                }
                
            } else {
                let bookDetails = BookDetails(category: category, timestamp: Date(), order: nil)
                
                userRef.updateData([
                    "booksDictionary.\(bookID)": [
                        "category": bookDetails.category,
                        "timestamp": bookDetails.timestamp as Any,
                        "order": bookDetails.order as Any
                    ]
                ]){ error in
                    if let error = error {
                        print("Error updating book category: \(error.localizedDescription)")
                    } else {
                        print("Book category updated successfully ")
                    }
                }
                if category == "reading" {
                    print("u")
                    self.updateReadingProgress(for: bookID, currentPage: 0)
                }
                
            }
        }
    }
    
    
    func fetchBookCategory(bookID: String, completion: @escaping (String?) -> Void) {
        guard let userRef = getUserRef() else { return }
        
        userRef.getDocument { document, error in
            
            if let document = document, document.exists {
                let data = document.data()
                // Retrieve the entire booksDictionary
                if let booksDictionary = data?["booksDictionary"] as? [String: [String: Any]],
                    // Access the category for the specific bookID
                   let bookDetailsData = booksDictionary[bookID]{
                    
                     let category = bookDetailsData["category"] as? String
                    completion(category)
                    print("Category: '\(category ?? "nil")'")
                } else {
                    print("booksDictionary not found")
                    completion(nil)
                }
            } else {
                print("Document does not exist or error occurred: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
    
    func fetchBooksIDs(from category: String, completion: @escaping ([String]) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No authenticated user found")
            completion([])
            return
        }
        
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                // Retrieve the entire booksDictionary
                if let booksDictionary = data?["booksDictionary"] as? [String: [String: Any]] {
                    // Filter book IDs by the specified category
                    let bookIDs = booksDictionary.compactMap { (key, value) -> String? in
                        // Extract the category field from the book details
                        if let bookDetails = value as? [String: Any],
                           let bookCategory = bookDetails["category"] as? String,
                           bookCategory == category {
                            return key
                        }
                        return nil
                    }
                    completion(bookIDs)
                } else {
                    print("booksDictionary not found")
                    completion([])
                }
            } else {
                print("Document does not exist or error occurred: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
            }
        }
    }
    
    func fetchBooksWithTimestamps(from category: String, completion: @escaping ([String: Date]) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No authenticated user found")
            completion([:])
            return
        }
        
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                if let booksDictionary = data?["booksDictionary"] as? [String: [String: Any]] {
                    // Filter book IDs by the specified category and get timestamps
                    let booksWithTimestamps = booksDictionary.filter { $0.value["category"] as? String == category }
                    let bookTimestamps = booksWithTimestamps.reduce(into: [String: Date]()) { result, item in
                        if let timestamp = (item.value["timestamp"] as? Timestamp)?.dateValue() {
                            result[item.key] = timestamp
                        }
                    }
                    completion(bookTimestamps)
                } else {
                    print("booksDictionary not found")
                    completion([:])
                }
            } else {
                print("Document does not exist or error occurred: \(error?.localizedDescription ?? "Unknown error")")
                completion([:])
            }
        }
    }
    
    func updateReadingProgress(for bookID: String, currentPage: Int) {
        guard let userRef = getUserRef() else { return }
        userRef.getDocument() { document, error in
            if let error = error {
                print("Error fetching user document ")
                return
            }
            guard let document = document, document.exists, let data = document.data() else {
                print("User document does not exist")
                return
            }
            if let readingProgress = data["readingProgress"] as? [String : [String : Any]],
               let readingProgressData = readingProgress[bookID] {
                
                let readingData = ReadingData(currentPage: currentPage, lastUpdate: Date())
        
                userRef.updateData([
                    "readingProgress.\(bookID)": [
                        "currentPage": readingData.currentPage,
                        "lastUpdate":readingData.lastUpdate
                    ]
                ]) { error in
                    if let error = error {
                        print("Error updating reading process: \(error.localizedDescription)")
                    } else {
                        print("Reading progress updated succesfully")
                    }
                }
                
            } else {
                let readingData = ReadingData(currentPage: currentPage, lastUpdate: Date())
                userRef.updateData([
                    "readingProgress.\(bookID)": [
                        "currentPage": readingData.currentPage,
                        "lastUpdate":readingData.lastUpdate
                    ]
                ]) { error in
                    if let error = error {
                        print("Error updating reading process: \(error.localizedDescription)")
                    } else {
                        print("Reading progress updated succesfully")
                    }
                }
            }
        }
        
    }
    
    func fetchReadingProgress(completion: @escaping ([String: ReadingData]?) -> Void) {
        guard let userRef = getUserRef() else {
            completion(nil)
            return
        }
        
        userRef.getDocument() { document, error in
            if let document = document, document.exists {
                let data = document.data()
                
                if let readingProgress = data?["readingProgress"] as? [String: [String: Any ]] {
                    var readingBooks: [String: ReadingData] = [:]
                    
                    for(bookID, progressData) in readingProgress {
                        if let currentPage = progressData["currentPage"] as? Int,
                           let lastUpdate = progressData["lastUpdate"] as? Timestamp {
                            
                            let readingData = ReadingData(
                                currentPage: currentPage,
                                lastUpdate: lastUpdate.dateValue())
                            readingBooks[bookID] = readingData
                        }
                    }
                    completion(readingBooks)
                    
                    
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
            
        }
        
    }
    
}
