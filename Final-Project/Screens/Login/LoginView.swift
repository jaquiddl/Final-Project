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
    
    var body: some View {
        ZStack {
            Color.brandPrimary
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                Title(title: "Log in")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 30)
                    .padding(.leading, 40)
                
                InputView(title: "Email",
                          text: $viewModel.email)
                .autocapitalization(.none)
                
                InputView(title: "Password",
                          text: $viewModel.password,
                          isSecureField: true)
                .autocapitalization(.none)
                Spacer()
                TaskButton(
                    title: "Log in",
                    action: {
                        try await authViewModel.signIn(withEmail: viewModel.email,
                                                       password: viewModel.password)
                    },
                    isEnabled: viewModel.formIsValid
                )
                
                CustomNavigationLink(destination: SignUpView(),
                                     labelText: "Don't have an account?",
                                     boldText: "Sign up")
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}


#Preview {
    LoginView()
}
