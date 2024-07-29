//
//  TitleAuthorStack.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 25/07/24.
//

import SwiftUI

struct TitleAuthorStack: View {
    
    var title: String
    var authors: [String]?
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5){
            Text(title)
                .fontWeight(.semibold)
            if let authors = authors, !authors.isEmpty {
                let authorNames = authors.joined(separator: ", ")
                Text("by \(authorNames)")
            }
        }
    }
}
