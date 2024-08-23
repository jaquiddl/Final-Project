//
//  ProfileView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 15/07/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    private var dimensions: CGFloat = 72.0
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        if let user = authViewModel.currentUser {
            NavigationStack {
                ScrollView {
                    LazyVStack (spacing: 10) {
                        HStack(spacing: 20){
                            Image(systemName: "rays")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color.brandPrimary)
                            Text("Status")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.brandPrimary)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Image(systemName: "slider.horizontal.3")
                                .resizable() // Makes the image resizable
                                .aspectRatio(contentMode: .fit) // Maintains the aspect ratio
                                .foregroundStyle(Color.brandPrimary)
                                .frame(width: 20, height: 20)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .onTapGesture {
                                    
                                    viewModel.isShowingSettings = true
                                }
                                .sheet(isPresented: $viewModel.isShowingSettings){
                                    VStack {
                                        Text("Settings")
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                        
                                        Divider()
                                        
                                        SettingsItem(systemName: "moon.fill", label: "Dark Mode", isToggle: true, isOn: viewModel.darkMode)
                                        SettingsItem(systemName: "bell.fill", label: "Notifications")
                                        SettingsItem(systemName: "person.fill", label: "Account")
                                        
                                        SettingsItem(systemName: "questionmark.circle.fill", label: "Support")
                                        Divider()
                                        taskButton(label: "Log out",
                                                   action: authViewModel.signOut,
                                                   borderColor: .clear,
                                                   fontStyle: .red)
                                        
                                    }
                                    .padding(.top, 20)
                                    .presentationDetents([.medium])
                                    .presentationDragIndicator(.visible)
                                    Spacer()
                                }
                            //                            NavigationLink(destination: SettingsView()) {
                            //
                            //                                Image(systemName: "slider.horizontal.3")
                            //                                    .resizable() // Makes the image resizable
                            //                                    .aspectRatio(contentMode: .fit) // Maintains the aspect ratio
                            //                                    .foregroundStyle(Color.brandPrimary)
                            //                                    .frame(width: 20, height: 20)
                            //                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            //
                            //                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 25, alignment: .center)
                        HStack(spacing: 20) {
                            ProfilePlaceholder(initials: user.initials, dimension: dimensions, font: .title)
                            VStack(alignment: .leading, spacing: 5) {
                                Text(user.fullName)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.brandPrimary)
                                
                                Text(viewModel.currentReading != nil ? "Now reading: \(viewModel.currentReading!)" : "No current readings")
                                    .font(.callout)
                                    .foregroundColor(.gray)
                            }
                                     
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20)
                        UserReadingsStack(read: "📖 \(viewModel.booksReadCount) read",
                                          toRead: "📚 \(viewModel.booksToReadCount) to read",
                                          reviewed: "✏️ \(user.reviewed.count) reviewed")
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
                        
                        PostsView()
                            .scrollIndicators(.hidden)
                        
                        
                    }
                    .padding()
                }
                .onAppear {
                    viewModel.getBooksIDs()
                }
            }
        }
    }
}


#Preview {
    // Mock data for preview
    let bookDetails = BookDetails(category: "Fiction", timestamp: Date(), order: 1)
    let mockUser = User(id: "123", fullName: "Preview User", email: "preview@example.com", booksDictionary: ["BookID1": bookDetails], reviewed: ["bookID1", "BookID2"])
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = mockUser
    
    return ProfileView().environmentObject(authViewModel)
}
