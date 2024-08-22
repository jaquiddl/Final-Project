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
            TitleAuthorStack(title: bookItem.volumeInfo.title,
                             authors: bookItem.volumeInfo.authors)
            }
        }
    }
    



#Preview {
    SPSearchCell(bookItem: MockData.mockBook1)
}
