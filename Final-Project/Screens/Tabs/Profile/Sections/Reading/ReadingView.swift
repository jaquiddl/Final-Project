//
//  ReadingView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 17/09/24.
//

import SwiftUI

struct ReadingView: View {
    @StateObject private var viewModel = ReadingViewModel()
    var body: some View {
        
        VStack {
            Text ("Now Reading")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .fontWeight(.semibold)
                .padding()
            List(Array(zip(viewModel.readingBooksItems, viewModel.currentPages)), id: \.0.id) { (book, currentPage) in
                readingBookPreview(bookItem: book, currentPage: currentPage)
                    .onTapGesture {
                        viewModel.selectedBook = book
                        viewModel.currentPage = currentPage
                        viewModel.isShowingDetails = true
                    }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
        }
        .sheet(item: $viewModel.selectedBook) { selectedItem in
            ProgressBookView( bookItem: selectedItem, currentPage: viewModel.currentPage, viewModel: viewModel)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            
        }
        .onAppear {
            viewModel.getReadingBooks() // Fetch the books when the view appears
        }
        
        
    }
}

#Preview {
    ReadingView()
}
