//
//  ProfileView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 15/07/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            
            
            VStack (spacing: 15) {
                HStack(spacing: 20) {
                    ProfilePlaceholder(initials: user.initials)
                    VStack(alignment: .center, spacing: 5) {
                        Text(user.fullName)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.brandPrimary)
                        Text("Current Reading")
                            .font(.callout)
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 25)
                UserReadingsStack(totalBooks: "📖 \(user.totalBooks) read",
                                  toRead: "📚 \(user.toRead) to read",
                                  reviewed: "✏️ \(user.reviewed) reviewed")
                HStack (spacing: 10){
                    Text("0 following")
                        .font(.callout)
                        .foregroundColor(.gray)
                    Text("0 followers")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                Divider()
                       .background(Color.gray)
                ScrollPage()
                
                
//                taskButton(label: "Sign Out",
//                           action: viewModel.signOut)
                Spacer()
            }
            .padding()
            
        }
    }
}


#Preview {
    // Mock data for preview
    let mockUser = User(id: "123", fullName: "Preview User", email: "preview@example.com", totalBooks: 0, toRead: 0, reviewed: 0)
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = mockUser
    
    return ProfileView().environmentObject(authViewModel)
}
