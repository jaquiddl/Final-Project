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
    var borderColor: Color = .brandPrimary
    
   
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            
            .frame(width: 260, height: 50)
            .foregroundColor(FontColor)
            .background(BGColor)
            
            .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(borderColor, lineWidth: 1)
        )
        .cornerRadius(20)
        
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
                .padding()
        }
        .font(.title3)
        .fontWeight(.semibold)
        
        .frame(maxWidth: .infinity, alignment: .center)
        .multilineTextAlignment(.center)
        .foregroundColor(.white)
        .disabled(!isEnabled)
        .background(Color(.brandPrimary))
        .cornerRadius(30)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))

    }
}

struct CustomNavigationLink<Destination: View>: View {
    var destination: Destination
    var labelText: String
    var boldText: String

    var body: some View {
        NavigationLink(destination: destination) {
            VStack(alignment: .center, spacing: 8) {
                Text(labelText)
                Text(boldText)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.brandPrimary)
        }
    }
}

struct taskButton: View {
    var label: String
    var action: () -> Void
    var borderColor: Color = .brandPrimary
    var fontStyle: Color = .brandPrimary
    
    
    var body: some View {
        Button(action:action) {
            Text(label)
                .font(.title3)
                .frame(width: 260, height: 50)
                .foregroundStyle(fontStyle)
                .background(Color(.white))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(borderColor, lineWidth: 1)
                )
        }
        .padding(.bottom, 40)
    }
    
}

struct newTaskButton: View {
    var action: () -> Void
    var label: LocalizedStringKey
    var BGColor: Color
    var FontColor: Color
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
        }
        .font(.title3)
        .fontWeight(.semibold)
        .frame(width: 260, height: 50)
        .foregroundColor(FontColor)
        .background(BGColor)
        .cornerRadius(10)
    }
}




