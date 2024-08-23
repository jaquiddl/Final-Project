//
//  ReadView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 04/09/24.
//

import SwiftUI

struct ReadView: View {
    @StateObject private var viewModel = ReadViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.readBooks, id: \.id) { book in
                
                SPSearchCell(bookItem: book) // Customize how you display each book
            }
        }
        .onAppear {
            viewModel.getReadBooksIDs()// Fetch the books when the view appears
        }
        
    }
}

#Preview {
    ReadView()
}
