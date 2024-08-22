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
        
        NavigationStack {
            VStack {
                SearchBar(searchTerm: $viewModel.searchTerm)
                    .onChange(of: viewModel.searchTerm) {
                        viewModel.getBooksWithDelay(query: viewModel.searchTerm, delay: 2)
                    }
                List(viewModel.filteredBooks, id: \.id) { book in
                    NavigationLink(destination: BookPreView(bookItem: book,
                                                         isShowingDetail: $viewModel.isSelected)) {
                        SPSearchCell(bookItem: book) // Customize how you display each book
                    }
                }
                .padding(.bottom)
            }
            .task { viewModel.getBooksWithDelay(query: viewModel.searchTerm, delay: 2) }
            
        }
    }
}



#Preview {
    SearchView()
}
