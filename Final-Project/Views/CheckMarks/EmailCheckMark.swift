//
//  EmailCheckMark.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 13/08/24.
//

import SwiftUI

struct EmailCheckMark: View {
    
    var isEmailValid: Bool = false
    var body: some View {
        Text(isEmailValid ? "Valid email" : "Invalid email")
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(isEmailValid ? .green : .brandPrimary)
            .opacity(0.5)
            .padding(.leading, 10)
            .padding(.top, -25)
    }
}
