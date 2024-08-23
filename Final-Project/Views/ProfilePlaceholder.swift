//
//  ProfilePlaceholder.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 03/08/24.
//

import SwiftUI


struct ProfilePlaceholder: View {
    
    var initials: String
    var dimension: CGFloat
    var font: Font
    
    var body: some View {
        Text(initials)
            .font(font)
            .fontWeight(.semibold)
            .foregroundColor(Color(.brandPrimary))
            .frame(width: dimension, height: dimension)
            .background(Color(.systemGray3))
            .clipShape(Circle())
    }    
}
