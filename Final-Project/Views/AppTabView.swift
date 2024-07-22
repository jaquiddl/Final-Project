//
//  ContentView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 12/07/24.
//

import SwiftUI

struct AppTabView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.userSession != nil {
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
                    LoginView()
                }
            }
            
        }
        
        
    }
}

#Preview {
    AppTabView().environmentObject(AuthViewModel())
}
