//
//  UserInfosView.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI

struct UserCreateView: View {
    
    @StateObject var userViewModel:UserViewModel
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var sex: String = ""
    @State private var company: String = ""
    @State private var biography: String = ""

    @State private var isRedirecting = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack {
                    Text("Créer votre profil")
                        .bold()
                        .font(.title)
                                        
                    VStack {
                        TextField("Prenom", text: $firstname)
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
                        
                        TextField("Nom", text: $lastname)
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
     
                        TextField("Sexe", text: $sex)
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
                 
                        TextField("Entreprise", text: $company)
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
                                Text("Biographie")
                                    .foregroundColor(.secondary)
                                    .padding(.leading, 10)
                                    .padding(.top, 8)
                            }
                        }
                
                    }
                    .lineSpacing(15)
                    .padding(.vertical, 50)
                }
                .padding(50)
                Button(action: {
                    self.createUser()
                    isRedirecting = true
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
                
                NavigationLink(destination: NavBarView(userViewModel: userViewModel), isActive: $isRedirecting) {
                    EmptyView()
                }
                .hidden()
                .navigationBarBackButtonHidden(true)
                Spacer()

            }
            
        }
    }
    
    func createUser() {
        Task {
            let user = User(id_user: 0, firstName: firstname, lastName: lastname, sex: sex, company: company, biography: biography, id: 0)
            userViewModel.currentUser = user
            await userViewModel.addUser(for: user)
        }
    }
}
