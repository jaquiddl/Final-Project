//
//  SearchImageCell.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 25/07/24.
//

import SwiftUI

struct SearchImageCell: View {
    var url: String?
    
    var body: some View {
        if let urlString = url, let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .foregroundColor(.red)
                        .frame(width: 60, height: 70)
                    
                case .success(let returnedImage):
                    returnedImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 70)
                    
                case .failure:
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(width: 60, height: 70)
                    
                default:
                    Image(systemName: "questionmark")
                        .font(.headline)
                        .frame(width: 60, height: 70)
                }
            }
        }
    }
}
