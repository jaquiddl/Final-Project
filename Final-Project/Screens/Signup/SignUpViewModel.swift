//
//  SignUpViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 20/07/24.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var fullName = ""
    @Published var password = ""
    @Published var alertItem: AlertItem?
    @Published var isTyping: Bool = true

    private var typingTimer: AnyCancellable?
    
    func fieldChanged() {
            isTyping = true

            // Cancel any existing timer
            typingTimer?.cancel()

            // Start a new timer
            typingTimer = Just(())
            .delay(for: .seconds(3.0), scheduler: RunLoop.main)
                .sink { [weak self] in
                    self?.isTyping = false
                }
        }
    
    var formIsValid: Bool {
        return email.isValidEmail
        && !password.isEmpty
        && password.isValidPassword
        && !fullName.isEmpty
    }
    
    
    var hasUppercase: Bool {
        let uppercaseRegEx = ".*[A-Z]+.*"
        let uppercaseTest = NSPredicate(format: "SELF MATCHES %@", uppercaseRegEx)
        return uppercaseTest.evaluate(with: password)
    }
    
    var hasLowercase: Bool {
        let lowercaseRegEx = ".*[a-z]+.*"
        let lowercaseTest = NSPredicate(format: "SELF MATCHES %@", lowercaseRegEx)
        return lowercaseTest.evaluate(with: password)
    }
    
    var hasDigit: Bool {
        let digitRegEx = ".*[0-9]+.*"
        let digitTest = NSPredicate(format: "SELF MATCHES %@", digitRegEx)
        return digitTest.evaluate(with: password)
    }
    
    var hasSpecialCharacter: Bool {
        let specialCharRegEx = ".*[!@#$&*]+.*"
        let specialCharTest = NSPredicate(format: "SELF MATCHES %@", specialCharRegEx)
        return specialCharTest.evaluate(with: password)
    }

    var hasValidLength: Bool {
        return password.count >= 8
    }
    
    var isValidPassword: Bool {
        return hasUppercase && hasLowercase && hasDigit && hasSpecialCharacter && hasValidLength
    }
}
