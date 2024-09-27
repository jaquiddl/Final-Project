//
//  UserReadingsStack.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 03/08/24.
//

import SwiftUI

struct UserReadingsStack: View {
    var read: String
    var toRead: String
    var reviewed: String
    
    var body: some View {
            HStack (spacing: 35){
                NavigationLink(destination: ReadView()) {
                    
                    Text(read)
                    
                }
                NavigationLink(destination: ToReadView()) {
                    
                    Text(toRead)
                    
                }
                Button(action: {
                    // Action when the "reviewed" item is tapped
                    print("Reviewed tapped: \(reviewed)")
                }) {
                    Text(reviewed)
                }        }
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.callout)
            .foregroundColor(.brandPrimary)
    }
}
