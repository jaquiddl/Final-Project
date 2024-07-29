//
//  AppSearchView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 12/07/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    
    var body: some View {

        VStack {
            SearchBar(searchTerm: $viewModel.searchTerm)
        
            List(viewModel.filteredBooks, id: \.id) { book in
                SPSearchCell(bookItem: book) // Customize how you display each book
            }
            .task { viewModel.books = await viewModel.getBooks() }
            Spacer()
        }
        
    }
}

#Preview {
    SearchView()
}
