//
//  SignUpView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 15/07/24.
//

import SwiftUI

struct SignUpView: View {
    

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        
        
        ZStack {
            Color.brandPrimary
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Title(title: "Sign up")
                    .padding(.bottom, 30)

                Spacer()
                    
                InputView(title: "Full Name",
                          text: $viewModel.fullName)
                        .autocapitalization(.none)
                InputView(title: "Email",
                          text: $viewModel.email)
                        .autocapitalization(.none)
                InputView(title: "Password",
                          text: $viewModel.password,
                          isSecureField: true)
                        .autocapitalization(.none)
                InputView(title: "Confirm Password",
                          text: $viewModel.passwordConfirmation,
                          isSecureField: true)
                        .autocapitalization(.none)
                Spacer()
                TaskButton(
                    title: "Sign up",
                    action: {
                        try await authViewModel.createUser(withEmail: viewModel.email,
                                                       password: viewModel.password,
                                                           fullname: viewModel.fullName)
                    },
                    isEnabled: viewModel.formIsValid
                )

                CustomNavigationLink(destination: LoginView(),
                                     labelText: "Already have an account?",
                                     boldText: "Log in")            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    SignUpView()
}
