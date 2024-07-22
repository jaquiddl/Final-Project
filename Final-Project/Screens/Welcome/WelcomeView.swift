//
//  WelcomeView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 14/07/24.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.brandPrimary
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    
                    Title(title: "Welcome to your Shelf")
                    Spacer()
                    NavigationLink (destination: LoginView()) {
                        WelcomeButton(title: "Log in to Shelf",
                                      BGColor: .white,
                                      FontColor: .brandPrimary)
                    }
                    
                    NavigationLink (destination: SignUpView()) {
                        WelcomeButton(title: "Sign up",
                                      BGColor: .clear,
                                      FontColor: .white)
                        .padding(.bottom, 25)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
