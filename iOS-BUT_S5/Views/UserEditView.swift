//
//  UserEditView.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI

struct UserEditView: View {
    
    @StateObject var userViewModel: UserViewModel
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var sex: String = ""
    @State private var company: String = ""
    @State private var biography: String = ""
        
    var body: some View {
        
        let user = userViewModel.currentUser
        VStack {
            Spacer()
            VStack {
                Text("Modifier votre profil")
                    .bold()
                    .font(.title)
                
                VStack {
                    HStack {
                        Text("Prenom")
                        TextField(user.firstName, text: $firstname)
                            .padding(10)
                            .overlay(
                                GeometryReader { geometry in
                                    Path { path in
                                        let width = geometry.size.width
                                        let height = geometry.size.height
                                        
                                        path.move(to: CGPoint(x: 0, y: height))
                                        path.addLine(to: CGPoint(x: width, y: height))
                                    }
                                    .stroke(Color.gray, lineWidth: 0.5)
                                }
                            )
                    }
                    
                    HStack {
                        Text("Nom")
                        TextField(user.lastName, text: $lastname)
                            .padding(10)
                            .overlay(
                                GeometryReader { geometry in
                                    Path { path in
                                        let width = geometry.size.width
                                        let height = geometry.size.height
                                        
                                        path.move(to: CGPoint(x: 0, y: height))
                                        path.addLine(to: CGPoint(x: width, y: height))
                                    }
                                    .stroke(Color.gray, lineWidth: 0.5)
                                }
                            )
                    }
                    
                    HStack {
                        Text("Sexe")
                        TextField(user.sex, text: $sex)
                            .padding(10)
                            .overlay(
                                GeometryReader { geometry in
                                    Path { path in
                                        let width = geometry.size.width
                                        let height = geometry.size.height
                                        
                                        path.move(to: CGPoint(x: 0, y: height))
                                        path.addLine(to: CGPoint(x: width, y: height))
                                    }
                                    .stroke(Color.gray, lineWidth: 0.5)
                                }
                            )
                    }
                    
                    HStack {
                        Text("Entreprise")
                        TextField(user.company, text: $company)
                            .padding(10)
                            .overlay(
                                GeometryReader { geometry in
                                    Path { path in
                                        let width = geometry.size.width
                                        let height = geometry.size.height
                                        
                                        path.move(to: CGPoint(x: 0, y: height))
                                        path.addLine(to: CGPoint(x: width, y: height))
                                    }
                                    .stroke(Color.gray, lineWidth: 0.5)
                                }
                            )
                    }
                    
                    VStack {
                        Text("Biographie")
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $biography)
                                .padding(10)
                                .overlay(
                                    GeometryReader { geometry in
                                        Path { path in
                                            let width = geometry.size.width
                                            let height = geometry.size.height
                                            
                                            path.move(to: CGPoint(x: 0, y: height))
                                            path.addLine(to: CGPoint(x: width, y: height))
                                        }
                                        .stroke(Color.gray, lineWidth: 0.5)
                                    }
                                )
                            if biography.isEmpty {
                                Text(user.biography)
                                    .foregroundColor(.secondary)
                                    .padding(.leading)
                                    .padding(.top)
                            }
                        }
                        
                    }
                }
                .lineSpacing(15)
                .padding(.vertical, 50)
            }
            .padding(50)
            Button(action: {
                self.editUser()
                    }) {
                        Text("Valider")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(minWidth: 0, maxWidth: 150)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(40)
                            .padding(.horizontal, 20)
                    }
            Spacer()

        }
        
    }
    
    func editUser() {
        Task {
            let user = User(id_user: userViewModel.currentUser.id_user, firstName: firstname, lastName: lastname, sex: sex, company: company, biography: biography, id: 0)
            userViewModel.currentUser = user
            await userViewModel.updateUser(for: user, id_user: userViewModel.currentUser.id_user)
        }
    }
}

//struct UserEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserEditView(user: User(id_user: 0, firstName: "Oui", lastName: "Oui", sex: "Oui", company: "Oui", biography: "Oui", id: 0))
//    }
//}
