//
//  TitleModifiers.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 15/07/24.
//

import SwiftUI

struct Title: View {
    
    var title: LocalizedStringKey
    var alignment: Alignment
    
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}
