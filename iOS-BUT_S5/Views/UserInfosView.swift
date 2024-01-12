//
//  UserInfosView.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI

struct UserInfosView: View {
    
    var user: User
    
    var body: some View {
        Text(user.firstName)
        Text(user.lastName)
        Text(user.sex)
        Text(user.company)
        Text(user.biography)
    }
}
