//
//  UserService.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import Foundation

enum UserError: Error {
    case failed
    case failedToDecode
    case invalidStatusCode
    case invalidStoreId
    case invalidUserId
    case invalidBody
}

struct UserService {
    
    let baseUrl = "http://10.248.3.104:8000"

    func fetchStoreUsers(for id_store: Int) async throws -> [User] {
        let url = "\(baseUrl)/user/store/\(id_store)"
        
        guard let url = URL(string: url) else {
            throw UserError.failed
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw UserError.invalidStatusCode
        }
        
        let decodedData = try JSONDecoder().decode([User].self, from: data)
        
        return decodedData
    }
    
    func createUser(for body: User) async throws {
        let url = "\(baseUrl)/user/"
        
//        print(body)
        
        guard let url = URL(string: url) else {
            throw UserError.failed
        }

        let jsonData = try? JSONEncoder().encode(body)
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: req)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 201 else {
            throw UserError.invalidStatusCode
        }
    }
    
    func editUser(for body: User, id_user: Int) async throws -> [User] {
        let url = "\(baseUrl)/user/update/\(id_user)"
        
        guard let url = URL(string: url) else {
            throw UserError.failed
        }
        
        let jsonData = try? JSONEncoder().encode(body)
        
        var req = URLRequest(url: url)
        req.httpMethod = "PUT"
        req.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: req)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw UserError.invalidStatusCode
        }
        
        let decodedData = try JSONDecoder().decode([User].self, from: data)
        
        return decodedData
    }
    
    func addUserToStore(for id_user: Int, id_store: Int) async throws {
        let url = "\(baseUrl)/user/inStore/\(id_user)/store/\(id_store)"
        
        guard let url = URL(string: url) else {
            throw UserError.failed
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "PUT"
        
        let (_, response) = try await URLSession.shared.data(for: req)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw UserError.invalidStatusCode
        }
    
    }
    
    func removeUserFromStore(for id_user: Int) async throws {
        let url = "\(baseUrl)/user/outStore/\(id_user)"
        
        guard let url = URL(string: url) else {
            throw UserError.failed
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "PUT"
        
        let (_, response) = try await URLSession.shared.data(for: req)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw UserError.invalidStatusCode
        }
    }
}
