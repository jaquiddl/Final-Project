//
//  readingBookPreview.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 20/09/24.
//

import SwiftUI

struct readingBookPreview: View {
    let bookItem: BookItem
    let currentPage: Int

    
    var body: some View {
        HStack(spacing: 10) {
            
            SearchImageCell(url: bookItem.volumeInfo.imageLinks?.smallThumbnail)
                .frame(width: 60, height: 70)
            VStack (alignment: .leading, spacing: 5){
                Text(bookItem.volumeInfo.title)
                    .fontWeight(.semibold)
                if let authors = bookItem.volumeInfo.authors, !authors.isEmpty {
                    let authorNames = authors.joined(separator: ", ")
                    Text("by \(authorNames)")
                }
                if let pageCount = bookItem.volumeInfo.pageCount {
                    let percentage = (Double(currentPage) / Double(pageCount)) * 100
                    ProgressView(value: Float(currentPage), total: Float(pageCount)) {
                    } currentValueLabel: {
                        Text(String(format: "%.0f%%", percentage)) // Display as an integer percentage (e.g., 50%)
                    }
                    .padding()
                    .tint(.brandPrimary)
                }
            }
        }
    }
}

//#Preview {
//    readingBookPreview(bookItem: MockData.mockBook1, viewModel: ReadingViewModel)
//}
