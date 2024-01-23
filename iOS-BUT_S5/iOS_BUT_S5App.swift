//
//  iOS_BUT_S5App.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI

@main
struct iOS_BUT_S5App: App {
    
    @StateObject var userViewModel = UserViewModel(service: UserService())
    
    var body: some Scene {
        WindowGroup {
            UserCreateView(userViewModel: userViewModel)
        }
    }
}
