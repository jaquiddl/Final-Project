//
//  NetworkManager.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 22/07/24.
//

import SwiftUI


final class NetworkManager {
    static let shared = NetworkManager()
    
    
    func getBooks() -> [BookItem]{
        return MockData.mockBooks
    }
    
}
