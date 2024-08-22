//
//  MenuItem.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 15/08/24.
//

import SwiftUI

struct MenuItem: View {
    var symbol: String
    var isSelected: Bool = false
    
    var body: some View {
        Image(systemName: isSelected && UIImage(systemName: "\(symbol).fill") != nil ? "\(symbol).fill" : symbol)
            .resizable() // Makes the image resizable
            .aspectRatio(contentMode: .fit) // Maintains the aspect ratio
            .frame(width: 25, height: 25) // Set the desired size
            .foregroundStyle(isSelected ? Color.brandPrimary : .gray) // Change color when selected
            .padding(.bottom, 10)
            .padding(.top, 5)
    }
}
