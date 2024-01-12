//
//  StoreModel.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import Foundation

struct Store: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var latitude: Double
    var longitude: Double
    var users: [User]
}
