//
//  User.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 14/07/24.
//

import Foundation


struct BookDetails: Codable {
    let category: String
    let timestamp: Date?
    let order: Int?
}
struct ReadingData: Codable {
    let currentPage: Int
    let lastUpdate: Date
}


struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    let booksDictionary: [String: BookDetails]
    let readingProgress: [String: ReadingData]
    let reviewed: [String]

    
//    var readBooks: [String] {
//        return booksDictionary.filter { $0.value == "read" }.map { $0.key }
//    }
//    var readingBooks: [String] {
//        return booksDictionary.filter {$0.value == "reading" }.map {$0.key}
//    }
//    var toReadBooks: [String] {
//        return booksDictionary.filter { $0.value == "toRead" }.map { $0.key }
//    }
 
    
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    
}

extension User {
    static var bookDetails = BookDetails(category: "Fiction", timestamp: Date(), order: 1)
    static var readingData = ReadingData(currentPage: 20, lastUpdate: Date())
    static var Mock_user = User(
        id: NSUUID().uuidString,
        fullName: "Jacqueline Diaz De Leon",
        email: "test@gmail.com",
        booksDictionary: ["BookID1": bookDetails],
        readingProgress: ["BookID1": readingData], // Use the instance of `bookDetails` here
        reviewed: []
    )
}
