//
//  PasswordView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 13/08/24.
//

import SwiftUI

struct PasswordView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = SignUpViewModel()
    @FocusState private var isEmailFieldFocused: Bool
    @FocusState private var isPasswordFieldFocused: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: 35){
            Spacer()
            Title(title: "Sign up", alignment: .leading)
                .padding(.bottom, 50)
            InputView(title: "Full Name",
                      text: $viewModel.fullName)
            .autocapitalization(.words)
            InputView(title: "Email",
                      text: $viewModel.email)
            .textContentType(.username)
            .autocapitalization(.none)
            .focused($isEmailFieldFocused)
            .onChange(of: viewModel.email) {
                viewModel.fieldChanged()
            }
            if isEmailFieldFocused && !viewModel.isTyping {
                EmailCheckMark(isEmailValid: viewModel.email.isValidEmail)
            }
            InputView(title: "Password",
                      text: $viewModel.password,
                      isSecureField: true)
            .textContentType(.newPassword)
            .focused($isPasswordFieldFocused)
            
            if isPasswordFieldFocused {
                PasswordCheckMarks(hasUppercase: viewModel.hasUppercase,
                                   hasLowercase: viewModel.hasLowercase,
                                   hasDigit: viewModel.hasDigit,
                                   hasSpecialCharacter: viewModel.hasSpecialCharacter,
                                   hasValidLength: viewModel.hasValidLength)
            }
            TaskButton(
                title: "Sign up",
                action: {
                    try await authViewModel.createUser(withEmail: viewModel.email,
                                                       password: viewModel.password,
                                                       fullname: viewModel.fullName)
                    dismiss()},
                isEnabled: viewModel.formIsValid)
            CustomNavigationLink(destination: LoginView(),
                                 labelText: "Already have an account?",
                                 boldText: "Log in")
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}


#Preview {
    PasswordView()
}
