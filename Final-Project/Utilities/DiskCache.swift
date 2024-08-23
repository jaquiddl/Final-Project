//
//  DiskCache.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 06/09/24.
//

import SwiftUI

class DiskCache {
    static let shared = DiskCache()
    
    private var cacheDirectory: URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
    func getBook(forKey key: String) -> BookItem? {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        
        return try? JSONDecoder().decode(BookItem.self, from: data)
    }
    func setBook(_ book: BookItem, forKey key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        let data = try? JSONEncoder().encode(book)
        try? data?.write(to: fileURL)
    }
}
