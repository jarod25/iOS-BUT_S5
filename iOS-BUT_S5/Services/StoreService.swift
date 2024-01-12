//
//  StoreService.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import Foundation

enum StoreError: Error {
    case failed
    case failedToDecode
    case invalidStatusCode
}

struct StoreService {
    
    let baseUrl = "http://10.248.2.189:8000"
    
    func fetchStore() async throws -> [Store] {
        let url = "\(baseUrl)/store"
        
        guard let url = URL(string: url) else {
            throw StoreError.failed
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw StoreError.invalidStatusCode
        }
        
        let decodedData = try JSONDecoder().decode([Store].self, from: data)
        
        return decodedData
    }
}
