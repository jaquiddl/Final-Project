//
//  LogInViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 20/07/24.
//

import SwiftUI
import Combine

class LogInViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLogInSuccesful: Bool = true
    @Published var isTyping: Bool = true

    private var typingTimer: AnyCancellable?
//    @Published var alertItem: AlertItem?
    
    var formIsValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    func emailChanged() {
        print(isTyping)
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
    
}
