//
//  AppSearchView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 12/07/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var isShowingDetails = false
    
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text ("Search")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                SearchBar(searchTerm: $viewModel.searchTerm)
                    .onChange(of: viewModel.searchTerm) {
                        viewModel.getBooksWithDelay(query: viewModel.searchTerm, delay: 2)
                    }
                List(viewModel.filteredBooks, id: \.id) { book in
                    //                    NavigationLink(destination: BookPreView(bookItem: book,
                    //                                                         isShowingDetail: $viewModel.isSelected))
                    SPSearchCell(bookItem: book)
                        .onTapGesture {
                            viewModel.selectedBook = book
                            viewModel.isShowingDetails = true
                            viewModel.getReadingBooks()
                        }
                }
                .padding(.bottom)
            }
            .task { viewModel.getBooksWithDelay(query: viewModel.searchTerm, delay: 0.5) }
            
            .sheet(item: $viewModel.selectedBook) { selectedItem in
                BookPreView(bookItem: selectedItem, viewModel: viewModel)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
                
            }
            
        }
        
    }
    
}



#Preview {
    SearchView()
}
