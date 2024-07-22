//
//  WelcomeButton.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 15/07/24.
//

import SwiftUI

struct WelcomeButton: View {
    
    var title: LocalizedStringKey
    var BGColor: Color
    var FontColor: Color
    
   
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 260, height: 50)
            .foregroundColor(FontColor)
            .background(BGColor)
            .cornerRadius(10)
        
    }
}

struct TaskButton: View {
    
    @StateObject private var viewModel = LogInViewModel()
    var title: String
    var action: () async throws -> Void
    var isEnabled: Bool
    var body: some View {
        Button {
            Task {
                try await action()
            }
        } label: {
            Text(title)
        }
        .font(.title3)
        .fontWeight(.semibold)
        .frame(width: 260, height: 50)
        .foregroundColor(.brandPrimary)
        .background(Color(.white))
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.5)
        .cornerRadius(10)
        .padding(.bottom, 40)

    }
}

struct CustomNavigationLink<Destination: View>: View {
    var destination: Destination
    var labelText: String
    var boldText: String

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(labelText)
                    .foregroundColor(.white)
                Text(boldText)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
}




