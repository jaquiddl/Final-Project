//
//  SignUpViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 20/07/24.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var fullName = ""
    @Published var password = ""
    @Published var passwordConfirmation = ""
    
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && passwordConfirmation == password
        && !fullName.isEmpty
    }
}
