//
//  LoginView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 16/07/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = LogInViewModel()
    @FocusState private var isEmailFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 35) {
                Spacer()
                
                Title(title: "Log in", alignment: .leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 30)
                
                InputView(title: "Email",
                          text: $viewModel.email)
                .textContentType(.username)
                .autocapitalization(.none)
                .focused($isEmailFieldFocused)
                .onChange(of: viewModel.email) {
                    viewModel.emailChanged()
                }
                if isEmailFieldFocused && !viewModel.isTyping {
                    EmailCheckMark(isEmailValid: viewModel.email.isValidEmail)
                }
                InputView(title: "Password",
                          text: $viewModel.password,
                          isSecureField: true)
                .textContentType(.password)
                if !authViewModel.isLoginSuccessful {
                    Text("Incorrect username or password :(")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(0.5)
                        .padding(.leading, 10)
                }
                Spacer()
                TaskButton(
                    title: "Log in",
                    action: {
                        try await authViewModel.signIn(withEmail: viewModel.email,
                                                       password: viewModel.password)
                        
                    }, isEnabled: viewModel.formIsValid)
                CustomNavigationLink(destination: PasswordView(),
                                     labelText: "Don't have an account?",
                                     boldText: "Sign up")
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
           
        }
    }
}


#Preview {
    LoginView().environmentObject(AuthViewModel())
}
