//
//  Book.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 22/07/24.
//

import Foundation

struct BooksResponse: Codable {
    let request: [BookItem]
}

// Define each item in the response
struct BookItem: Codable, Identifiable {
    var id: Int
    let volumeInfo: Book
}

// Define the book details
struct Book: Codable {
    let title: String
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let industryIdentifiers: [IndustryIdentifier]?
    let imageLinks: ImageLinks?
}

// Define the industry identifiers
struct IndustryIdentifier: Codable {
    let type: String
    let identifier: String
}

// Define the image links (e.g., cover images)
struct ImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
}



struct MockData {
    
    static let mockBook1 = BookItem(id: 01,
                             volumeInfo: Book(title: "The invisible life of addie la rue",
                                              authors: ["V.E SCHWAB"],
                                              publisher: "TOR",
                                              publishedDate: "2020",
                                              description: "Never pray to the gods that answer after dark",
                                              industryIdentifiers: [
                                                IndustryIdentifier(type: "ISBN_10", identifier: "1234567890"),
                                                IndustryIdentifier(type: "ISBN_13", identifier: "123-1234567890")
                                              ],
                                              imageLinks: ImageLinks(
                                                smallThumbnail: "https://example.com/thumbnail.jpg",
                                                thumbnail: "https://example.com/thumbnail.jpg")
                                             ))
    
    static let mockBook2 = BookItem(id: 02,
                             volumeInfo: Book(title: "The Swift Programming Language",
                                              authors: ["Apple Inc."],
                                              publisher: "Apple Books",
                                              publishedDate: "2023-01-01",
                                              description: "A comprehensive guide to Swift programming language.",
                                              industryIdentifiers: [
                                                IndustryIdentifier(type: "ISBN_10", identifier: "1234567890"),
                                                IndustryIdentifier(type: "ISBN_13", identifier: "123-1234567890")
                                              ],
                                              imageLinks: ImageLinks(
                                                smallThumbnail: "https://example.com/smallThumbnail.jpg",
                                                thumbnail: "https://example.com/thumbnail.jpg")
                                             ))
    
    static let mockBook3 = BookItem(id: 03,
                             volumeInfo: Book(title: "The alchemist",
                                              authors: ["John Swift."],
                                              publisher: "Rocco Ltd",
                                              publishedDate: "1994",
                                              description: "To realize one's destiny is a person's only obligation",
                                              industryIdentifiers: [
                                                IndustryIdentifier(type: "ISBN_10", identifier: "978"),
                                                IndustryIdentifier(type: "ISBN_13", identifier: "")
                                              ],
                                              imageLinks: ImageLinks(
                                                smallThumbnail: "",
                                                thumbnail: "")
                                             ))
    
    static let mockBooks = [mockBook1, mockBook2, mockBook3]
}
