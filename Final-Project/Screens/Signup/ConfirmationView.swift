//
//  ConfirmationView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 15/08/24.
//

import SwiftUI

struct ConfirmationView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack (alignment: .trailing, spacing: 20) {
            Title(title: "You're all done.", alignment: .trailing)
                
            Text("Succesfully created account")
                .padding(.bottom, 20)

            CustomNavigationLink(destination: LoginView(),
                                 labelText: "",
                                 boldText: "Continue")
        }
        .navigationBarBackButtonHidden(true)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
        
}
#Preview {
    ConfirmationView()
}
