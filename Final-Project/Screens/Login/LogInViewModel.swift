//
//  LogInViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 20/07/24.
//

import SwiftUI

class LogInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    var formIsValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
}
