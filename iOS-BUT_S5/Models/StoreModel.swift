//
//  StoreModel.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import Foundation

struct Store: Codable, Hashable {
    
    var id_store: Int
    var name: String
    var latitude: String
    var longitude: String
    var users: [User]
}
