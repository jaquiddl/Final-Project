//
//  ContentView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 12/07/24.
//

import SwiftUI

struct AppTabView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @AppStorage("isWelcomeScreenOver") var isWelcomeScreenOver = false
    
    var body: some View {
        if isWelcomeScreenOver {
            if let _ = viewModel.userSession {
                if let _ = viewModel.currentUser  {
                    TabView {
                        HomeView()
                            .tabItem {
                                Label("", systemImage: "house")
                            }
                        SearchView()
                            .tabItem {
                                Label("", systemImage: "sparkle.magnifyingglass")
                            }
                        CreateView()
                            .tabItem {
                                Label("", systemImage: "plus")
                            }
                        ConnectView()
                            .tabItem {
                                Label("", systemImage: "rectangle.3.group.bubble")
                            }
                        ProfileView()
                            .tabItem {
                                Label("", systemImage: "person")
                            }
                    }
                    .tint(.brandPrimary)
                } else {
                    Text("Loading user data...")
                }
                
            } else {
                LoginView()
            }
        } else {
            WelcomeView()
        }
        
        
    }
    
}

#Preview {
    AppTabView().environmentObject(AuthViewModel())
}
