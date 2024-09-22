//
//  PasswordCheckMarks.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 13/08/24.
//

import SwiftUI

struct PasswordCheckMarks: View {
    var hasUppercase: Bool
    var hasLowercase: Bool
    var hasDigit: Bool
    var hasSpecialCharacter: Bool
    var hasValidLength: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            Text("At least 1 uppercase letter")
                .foregroundStyle(hasUppercase ? Color.green : Color.brandPrimary)
            Text("At least 1 lower case letter")
                .foregroundStyle(hasLowercase ? Color.green : Color.brandPrimary)
            Text("At least 1 digit")
                .foregroundStyle(hasDigit ? Color.green : Color.brandPrimary)
            Text("At leats 1 special character")
                .foregroundStyle(hasSpecialCharacter ? Color.green : Color.brandPrimary)
            Text("Minimun 8 characters")
                .foregroundStyle(hasValidLength ? Color.green : Color.brandPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .opacity(0.5)
        .padding(.leading, 10)
        .padding(.top, -25)
    }
        
}
