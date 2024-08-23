//
//  test.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 22/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack {
                // Profile Header Section
                VStack {
                    // Profile picture, bio, and other info
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 300)
                        .overlay(
                            Text("Profile Header")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        )
                }
                .frame(maxWidth: .infinity)
                
                // Tabs Section (Posts, Reels, etc.)
                TabView(selection: $selectedTab) {
                    
                    // Tab 1 (e.g. Grid of posts)
                   
                    GridContentView()
                        .tabItem { Label("", systemImage: "house")
                        }
                        .tag(0)
                    
                    // Tab 2 (e.g. Reels, other content)
                   
                    PostsView()
                        .tabItem { Label("", systemImage: "house")
                        }
                    .tag(1)
                    
                    // Add more tabs if needed
                }
                .frame(height: UIScreen.main.bounds.height * 0.75)  // Make the TabView take up more height
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Horizontal scrolling tabs
                .padding(.top)
            }
        }
    }
}

struct GridContentView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<30) { index in
                Rectangle()
                    .fill(Color.blue)
                    .aspectRatio(1, contentMode: .fit)
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
