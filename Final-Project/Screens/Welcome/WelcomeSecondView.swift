//
//  WelcomeView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 14/07/24.
//

import SwiftUI

struct WelcomeSecondView: View {
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Rectangle()
                    .frame(height: 200)
                    .foregroundStyle(Color.clear)
                
                Title(title: "Ready for the plot twist? Because we are", alignment: .leading)
                Spacer()
                NavigationLink (destination: LoginView()) {
                    WelcomeButton(title: "Log in to Plotf",
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

#Preview {
    WelcomeSecondView()
}
