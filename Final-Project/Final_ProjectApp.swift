//
//  Final_ProjectApp.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 12/07/24.
//

import SwiftUI
import Firebase

@main
struct Final_ProjectApp: App {
    
    @StateObject private var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(viewModel)
        }
    }
}
