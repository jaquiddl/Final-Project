//
//  User.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 14/07/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    let totalBooks: Int
    let toRead: Int
    let reviewed: Int

    
    
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
    static var Mock_user = User(id: NSUUID().uuidString, fullName: "Jacqueline Diaz De Leon", email: "test@gmail.com", totalBooks: 0, toRead: 0, reviewed: 0)
}
