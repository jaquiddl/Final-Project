//
//  Post.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 22/08/24.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: Int
    let postAuthor: String
    let contentText: String
    
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: postAuthor) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension Post {
    static var Mock_user = Post(id: 01, postAuthor: "Jacqueline Diaz De Leon", contentText: "This is my firts post. Hello World! Welcome to my profile")
}

struct PostMockData {
    static let post1 = Post(id: 01, postAuthor: "Mock User", contentText: "This is my firts post. Hello World! Welcome to my profile")
    static let post2 = Post(id: 02, postAuthor: "Mock User", contentText: "Just started 'The invisible life of Addie La Rue'.")
//    static let post3 = Post(id: 03, postAuthor: "Africa", contentText: "This is my firts post. Hello World! Welcome to my profile")
//    static let post4 = Post(id: 04, postAuthor: "Paulina Diaz", contentText: "This is my firts post. Hello World! Welcome to my profile")
//    static let post5 = Post(id: 05, postAuthor: "Paulina Diaz", contentText: "This is my firts post. Hello World! Welcome to my profile")
//    static let post6 = Post(id: 06, postAuthor: "Paulina Diaz", contentText: "This is my firts post. Hello World! Welcome to my profile")
    
    static let posts = [post1, post2/*, post3, post4, post5, post6*/]
}
