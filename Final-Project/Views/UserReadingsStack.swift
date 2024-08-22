//
//  UserReadingsStack.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 03/08/24.
//

import SwiftUI

struct UserReadingsStack: View {
    var totalBooks: String
    var toRead: String
    var reviewed: String
    
    var body: some View {
        HStack (spacing: 20){
            Text(totalBooks)
                
            Text(toRead)
                
            Text(reviewed)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .font(.callout)
        .foregroundColor(.brandPrimary)
        
    }
}
