//
//  ProfileNavigationView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 19/08/24.
//

    
import SwiftUI

enum NavigationSection: String, CaseIterable, Identifiable {
    case posts = "square.and.pencil"
    case authors = "books.vertical"
    case bookshelf = "square.stack"
    case collections = "person.crop.artframe"
    
    var id: String { rawValue }
}

struct ScrollPage: View {
//    @State private var width: CGFloat = 0
    private let itemWidth: CGFloat = UIScreen.main.bounds.width
    @State private var selectedSection: NavigationSection = .posts
    private let spacing: CGFloat = 25
    
    var body: some View {
            VStack {
                HStack(spacing: 25) {
                    ForEach(NavigationSection.allCases) { section in
//                        GeometryReader { geometry in
                            MenuItem(symbol: section.rawValue, isSelected: selectedSection == section)
                                .frame(maxWidth: .infinity)
//                                .onAppear{
//                                    self.width = geometry.size.width
//                                }
                                .onTapGesture {
                                    withAnimation {
                                        selectedSection = section
                                    }
                                }
//                        }
//                        .frame(height: 30)
                    }
                }
                GeometryReader { geometry in
                    let sectionCount = CGFloat(NavigationSection.allCases.count)
                    let totalWidth = geometry.size.width
                    let sectionWidth = (totalWidth - (spacing * (sectionCount - 1))) / sectionCount
                    let underlineOffset = CGFloat(selectedSectionIndex()) * (sectionWidth + spacing)

                    Rectangle()
                        .frame(width: sectionWidth, height: 2)
                        .foregroundColor(.brandPrimary)
                        .offset(x: underlineOffset)
                        .animation(.spring(), value: selectedSectionIndex())
                }
                .frame(height: 2)
                // Sections
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                         HStack(spacing: 5) {
                            ForEach(NavigationSection.allCases) { section in
                                sectionView(for: section)
                                    .frame(width: itemWidth, height: 400)
                                    .contentShape(Rectangle()) // Makes the entire area tappable
                                    .id(section)
                            }
                        }
                        .onChange(of: selectedSection) {
                            withAnimation {
                                scrollProxy.scrollTo(selectedSection, anchor: .center)
                            }
                        }
                    }
                    .gesture(DragGesture(minimumDistance: 0))
                    .scrollTargetLayout()
                    .scrollTargetBehavior(.viewAligned)
                }
                
            }
        }
      
    private func selectedSectionIndex() -> Int {
        NavigationSection.allCases.firstIndex(of: selectedSection) ?? 0
    }

    @ViewBuilder
    private func sectionView(for section: NavigationSection) -> some View {
        switch section {
        case .posts:
            PostsView()
        case .authors:
            AuthorsView()
        case .bookshelf:
            BookshelfView()
        case .collections:
            CollectionsView()
        }
    }
}


#Preview {
    ScrollPage()
}
