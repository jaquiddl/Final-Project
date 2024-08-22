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
        VStack (alignment: .center, spacing: 35) {
            Title(title: "Let's get started", alignment: .leading)
                .padding(.bottom, 20)
                .padding(.leading, 50)
            //            taskButton(
            //                label: "Continue with google",
            //                action: )
            //            taskButton(
            //                label: "Continue with apple",
            //                action: )
            //            taskButton(
            //                label: "Continue with Email",
            //                action: )
            NavigationLink (destination: PasswordView()) {
                WelcomeButton(title: "Continue with Email",
                              BGColor: .brandPrimary,
                              FontColor: .white,
                              borderColor:.clear)
            }

            CustomNavigationLink(destination: LoginView(),
                                 labelText: "Already have an account?",
                                 boldText: "Log in")
        }
        .navigationBarBackButtonHidden(true)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
        
}
    


    

#Preview {
    SignUpView()
}
