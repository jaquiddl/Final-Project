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
            ZStack {
                VStack {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                            .padding()
                        VStack {
                            Text(user.fullName)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.bottom, 2)
                            Text("Current Reading")
                                .font(.callout)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    HStack (spacing: 5){
                        Text("📖 100 read")
                            .frame(maxWidth: .infinity)
                            .font(.callout)
                            .foregroundColor(.white)
                        Text("📚 20 to read")
                            .frame(maxWidth: .infinity)
                            .font(.callout)
                            .foregroundColor(.white)
                        Text("✏️ reviewed")
                            .frame(maxWidth: .infinity)
                            .font(.callout)
                            .foregroundColor(.white)
            
                    }
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    HStack (spacing: 10){
                        Text("0 following")
                            .font(.callout)
                            .foregroundColor(.gray)
                        Text("0 followers")
                            .font(.callout)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    
                    Title(title: "Settings")
                    
                    Button {
                        viewModel.singOut()
                    } label: {
                        Text("Sign out")
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(width: 260, height: 50)
                    .foregroundColor(.brandPrimary)
                    .background(Color(.white))
                    .cornerRadius(10)
                    .padding(.bottom, 40)
                    
                    
                    Spacer()
                    
                    
                }
            }
        }
    }
}

#Preview {
    ProfileView().environmentObject(AuthViewModel())
}
