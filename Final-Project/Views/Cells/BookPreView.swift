//
//  BookPreView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 31/07/24.
//

import SwiftUI

struct BookPreView: View {
    
    let bookItem: BookItem
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Color.indigo
                        .cornerRadius(30)
                        .frame(height: UIScreen.main.bounds.height * 0.6)
                    VStack (spacing: 15){
                        SearchImageCell(url: bookItem.volumeInfo.imageLinks?.smallThumbnail)
                            .frame(width: 170, height: 240)
                            .padding()
                        Text(bookItem.volumeInfo.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(bookItem.volumeInfo.authors?.joined(separator: ", ") ?? "")
                        Text(bookItem.volumeInfo.publisher ?? "")
                    }
                }
                Spacer()
                
                VStack(alignment: .leading,spacing: 10) {
                    Text("Description")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(bookItem.volumeInfo.description ?? "")
                    Spacer()
                }
                .frame(height: 300)
                .padding(.top)
                .padding(.leading)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BookPreView(bookItem: MockData.mockBook1, isShowingDetail: .constant(true))
}
struct BookDetail: View {
    
    let title: String
    let value: String
    
    var body: some View {
        
        VStack(spacing: 8) {
            Text(title)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
                .font(.headline)
            
            Text(value)
                .fontWeight(.bold)
            
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
