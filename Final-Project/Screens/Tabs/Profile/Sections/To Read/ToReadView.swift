//
//  ToReadView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 09/09/24.
//

import SwiftUI

struct ToReadView: View {
    @StateObject private var viewModel = ToReadViewModel()

    var body: some View {

            VStack {
                Text ("To Read Books ")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                List(viewModel.toReadBooks, id: \.id) { book in
                    
                        SPSearchCell(bookItem: book) // Customize how you display each book
                    }
            }
            .onAppear {
                viewModel.getToReadBooksIDs() // Fetch the books when the view appears
            }

    }
}

#Preview {
    ToReadView()
}
