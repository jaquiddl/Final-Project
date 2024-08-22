//
//  ProfilePlaceholder.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 03/08/24.
//

import SwiftUI


struct ProfilePlaceholder: View {
    
    var initials: String
    
    var body: some View {
        Text(initials)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(Color(.brandPrimary))
            .frame(width: 72, height: 72)
            .background(Color(.systemGray3))
            .clipShape(Circle())
    }    
}
