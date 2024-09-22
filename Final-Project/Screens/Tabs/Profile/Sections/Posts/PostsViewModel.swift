//
//  PostsViewModel.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 22/08/24.
//

import SwiftUI


final class PostsViewModel: ObservableObject {
    @Published var postInformation: [Post] = []
}
