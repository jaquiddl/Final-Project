//
//  HorizontalMenu.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 15/08/24.
//

import SwiftUI

//struct HorizontalMenu: View {
//    @State private var selectedMenuItem: Int? = nil
//
//    var body: some View {
//            HStack(alignment: .center ) {
//                MenuItem(symbol: "square.and.pencil", isSelected: selectedMenuItem == 0)
//                    .onTapGesture {
//                        selectedMenuItem = 0
//                    }
//                    .frame(maxWidth: .infinity)
//                    .overlay(
//                        Rectangle()
//                            .fill(Color.brandPrimary)
//                            .frame(height: 2)
//                            .frame(maxHeight: .infinity, alignment: .bottom)
//                        , alignment: .bottom
//                    )
//                    .padding()
//                MenuItem(symbol: "books.vertical", isSelected: selectedMenuItem == 1)
//                    .onTapGesture {
//                        selectedMenuItem = 1
//                    }
//                    .frame(maxWidth: .infinity)
//                MenuItem(symbol: "square.stack", isSelected: selectedMenuItem == 2)
//                    .onTapGesture {
//                        selectedMenuItem = 2
//                    }
//                    .frame(maxWidth: .infinity)
//                MenuItem(symbol: "person.crop.artframe", isSelected: selectedMenuItem == 3)
//                    .onTapGesture {
//                        selectedMenuItem = 3
//                    }
//                    .frame(maxWidth: .infinity)
//            }
//            .frame(maxWidth: .infinity, alignment: .center)
//
//    }
//}

struct HorizontalMenu: View {
    @State private var selectedIndex: Int = 0
    
    let menuItems = ["square.and.pencil", "books.vertical", "square.stack", "person.crop.artframe"]
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(Array(menuItems.enumerated()), id: \.offset) { index, item in
                    MenuItem(symbol: menuItems[index])
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            withAnimation {
                                print("Selected Index: \(selectedIndex)")
                                selectedIndex = index
                                print(selectedIndex)
                                
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity)
            GeometryReader { geometry in
                let itemWidth = geometry.size.width / CGFloat(menuItems.count)
                Rectangle()
                    .frame(width: itemWidth, height: 2)
                    .foregroundColor(.brandPrimary)
                    .offset(x: CGFloat(selectedIndex) * itemWidth)
                    .animation(.easeInOut(duration: 2.3), value: selectedIndex)
            }
        }
        
    }
}

#Preview {
    HorizontalMenu()
}
