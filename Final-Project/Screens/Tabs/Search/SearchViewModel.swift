//
//  SearchViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 22/07/24.
//

import SwiftUI
import Combine


final class SearchViewModel: ObservableObject {
    @Published var books: [BookItem] = []
    @Published var searchTerm: String = ""
    
    
    func getBooks() async -> [BookItem] {
        return MockData.mockBooks
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

 
