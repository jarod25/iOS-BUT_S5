//
//  UserModel.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import Foundation

struct User: Codable, Hashable {
    var id_user: Int
    var firstName: String
    var lastName: String
    var sex: String
    var company: String
    var biography: String
    var id_store: Int
}
