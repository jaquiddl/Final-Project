//
//  SettingItem.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 30/08/24.
//

import SwiftUI

struct SettingsItem: View {
    var systemName: String
    var label: String
    var isToggle: Bool = false
    @State var isOn: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
            if isToggle {
                Toggle(label, isOn: $isOn)
            }
            else {
                Text(label)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.forward")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.top)
    }
}
