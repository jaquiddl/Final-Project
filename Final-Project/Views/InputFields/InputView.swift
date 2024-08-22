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
        VStack (alignment: .leading, spacing: 20) {
            Text(title)
                .foregroundColor(.brandPrimary)
                .fontWeight(.semibold)
                .font(.system(size: 18))
                .opacity(0.5)
            if isSecureField {
                SecureField("", text: $text)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.bottom, 10)
                    .overlay(
                        Rectangle()
                            .frame( height: 1)
                            .opacity(0.5)
                            .foregroundColor(.brandPrimary),
                        alignment: .bottom
                
                    )
            } else {
                TextField("", text: $text)
                    .disableAutocorrection(true)
                    .padding(.bottom, 10)
                    .overlay(
                        Rectangle()
                            .frame( height: 1)
                            .opacity(0.5)
                            .foregroundColor(.brandPrimary),
                        alignment: .bottom
                    )
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        
    }
}
