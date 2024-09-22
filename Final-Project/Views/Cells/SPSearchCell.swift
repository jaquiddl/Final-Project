//
//  SPSearchCell.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 24/07/24.
//

import SwiftUI

struct SPSearchCell: View {
    
    let bookItem: BookItem
    
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
            }
        }
    }
}
    



#Preview {
    SPSearchCell(bookItem: MockData.mockBook1)
}
