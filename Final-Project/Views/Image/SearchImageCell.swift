//
//  SearchImageCell.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 25/07/24.
//

import SwiftUI

//final class ImageLoader: ObservableObject {
//    
//    @Published var image: Image? = nil
//    
//    func load(fromURLString urlString: String) {
//
//    }
//}

import SwiftUI

struct SearchImageCell: View {
    var url: String?
    
    var body: some View {
        if let urlString = url, let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    Color.secondary // Placeholder color while loading
                case .success(let image):
                    image.resizable() // Ensure the image is resizable
                case .failure:
                    Color.gray // Error color
                @unknown default:
                    Color.gray // Fallback color for any other unknown states
                }
            }
            .onAppear {
                
            }
        } else {
            Color.clear // Handle case where URL is nil
        }
    }
}
