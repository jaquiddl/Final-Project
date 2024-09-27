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
            VStack {
                SearchImageCell(url: bookItem.volumeInfo.imageLinks?.smallThumbnail)
                    .frame(width: 85, height: 110)
            }
            
            VStack (alignment: .leading, spacing: 5){
                Text(bookItem.volumeInfo.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                if let authors = bookItem.volumeInfo.authors, !authors.isEmpty {
                    let authorNames = authors.joined(separator: ", ")
                    Text("by \(authorNames)")
                }
                if let pageCount = bookItem.volumeInfo.pageCount {
                    let percentage = (Double(currentPage) / Double(pageCount)) * 100
                    ProgressView(value: Float(currentPage), total: Float(pageCount)) {
                    } currentValueLabel: {
                        Text(String(format: "%.0f%%", percentage))
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.top, 5)// Display as an integer percentage (e.g., 50%)
                    }
                    .padding()
                    .tint(.brandPrimary)
                }
            }
        }
        .frame(height: 140)
    }
}

#Preview {
    readingBookPreview(bookItem: MockData.mockBook1, currentPage: 50)
}
