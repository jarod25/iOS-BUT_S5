//
//  UserEditView.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI

struct UserEditView: View {
    
    @ObservedObject var userViewModel: UserViewModel
    @State private var firstname: String
    @State private var lastname: String
    @State private var sex: String
    @State private var company: String
    @State private var biography: String
    
    @State private var isFormValid: Bool = false
    
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        let user = userViewModel.currentUser
        _firstname = State(initialValue: user.firstName)
        _lastname = State(initialValue: user.lastName)
        _sex = State(initialValue: user.sex)
        _company = State(initialValue: user.company)
        _biography = State(initialValue: user.biography)
    }
        
    var body: some View {
        
        VStack {
            Spacer()
            VStack {
                Text("Modifier votre profil")
                    .bold()
                    .font(.title)
                
                VStack {
                    HStack {
                        Text("Prenom")
                        TextField("", text: $firstname)
                            .onChange(of: firstname) { _ in validateForm()}
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
                        TextField("", text: $lastname)
                            .onChange(of: lastname) { _ in validateForm()}
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
                        TextField("",text: $sex)
                            .onChange(of: sex) { _ in validateForm()}
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
                        TextField("", text: $company)
                            .onChange(of: company) { _ in validateForm()}
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
                            .padding(.top, 25)
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $biography)
                                .onChange(of: biography) { _ in validateForm()}
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
                    .disabled(!isFormValid)

            Spacer()

        }
    }
    
    private func validateForm() {
        isFormValid = !firstname.isEmpty && !lastname.isEmpty && !sex.isEmpty && !company.isEmpty && !biography.isEmpty
    }
    
    func editUser() {
        Task {
            let user = User(id_user: userViewModel.currentUser.id_user, firstName: firstname, lastName: lastname, sex: sex, company: company, biography: biography, id: 0)
            userViewModel.currentUser = user
            await userViewModel.updateUser(for: user, id_user: userViewModel.currentUser.id_user)
        }
    }
}
