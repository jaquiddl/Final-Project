//
//  PostsView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 19/08/24.
//

import SwiftUI

struct PostsView: View {
    @StateObject private var viewModel = PostsViewModel()
    
    var body: some View {
        
        LazyVStack(alignment: .leading) {
                        ForEach(PostMockData.posts, id: \.id) { postInformation in
                            PostCell(post: postInformation)
                            Divider()
                        }
                    }
                    .frame(maxWidth: .infinity)
        
    }
}

#Preview {
    PostsView()
}
