//
//  UserInfosView.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI

struct UserInfosView: View {
    
    @StateObject var userViewModel = UserViewModel(service: UserService())
    
    @State private var firstname = ""
    @State private var name = ""
    @State private var sex = ""
    @State private var company = ""
    @State private var biography = ""
    
    var body: some View {
        TextField("Prénom", text: $firstname)
        TextField("Prénom", text: $name)
        TextField("Prénom", text: $sex)
        TextField("Prénom", text: $company)
        TextField("Prénom", text: $biography)
    }
    // bouton quand je clique sur le btn j'ppelle createUser
    
    func createUser() {
        Task {
            let user = User(id_user: 0, firstName: firstname, lastName: name, sex: sex, company: company, biography: biography, id: 0)
            await userViewModel.addUser(for: user)
        }
    }
}
