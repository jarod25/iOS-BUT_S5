//
//  iOS_BUT_S5App.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI

@main
struct iOS_BUT_S5App: App {
    var body: some Scene {
        WindowGroup {
            NavBarView(user: User(id_user: 0, firstName: "", lastName: "", sex: "", company: "", biography: "", id: 0))
        }
    }
}
