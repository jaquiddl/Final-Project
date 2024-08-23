//
//  PostCell.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 22/08/24.
//

import SwiftUI

struct PostCell: View {
    let post : Post
    var hoursAgo: Int = 15
    let screenDimensions = UIScreen.main.bounds.width
    
    
    var body: some View {
       
            HStack {
                VStack {
                    ProfilePlaceholder(initials: post.initials, dimension: 40.0, font: .body)
                        .padding()
                    Spacer()
                }
                VStack {
                    HStack {
                        Text(post.postAuthor)
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.brandPrimary)
                        Divider()
                            .frame(width: 0.8, height: 18)
                            .background(Color.gray)
                        Text("\(hoursAgo)h")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text(post.contentText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.trailing)
            
                
                
            }
            .frame(width: screenDimensions, height: 170)
        }
            
    }

#Preview {
    PostCell(post: PostMockData.post1)
}
