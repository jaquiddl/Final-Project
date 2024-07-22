//
//  InputView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 16/07/24.
//

import SwiftUI

struct InputView: View {
    
    let title: String
    @Binding var text: String
    
    var isSecureField = false

    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.system(size: 18))
            if isSecureField {
                SecureField("", text: $text)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .frame(width: 310)
                    .background(Color.white) // Set background color
                    .cornerRadius(10) // Optional: Round the corners
                    .padding(.bottom)
            } else {
                TextField("", text: $text)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .frame(width: 310)
                    .background(Color.white) // Set background color
                    .cornerRadius(10) // Optional: Round the corners
                    .padding(.bottom)
            }
        }
    }
}
