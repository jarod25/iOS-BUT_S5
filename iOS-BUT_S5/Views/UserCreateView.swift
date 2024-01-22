//
//  UserInfosView.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI

struct UserCreateView: View {
    
    @StateObject var userViewModel = UserViewModel(service: UserService())
    
    @AppStorage("id_user") private var id_user: Int = 0
    @AppStorage("firstname") private var firstname: String = ""
    @AppStorage("lastname") private var lastname: String = ""
    @AppStorage("sex") private var sex: String = ""
    @AppStorage("company") private var company: String = ""
    @AppStorage("biography") private var biography: String = ""
    
    @State private var currentUser = User(id_user: 0, firstName: "", lastName: "", sex: "", company: "", biography: "", id: 0)
    
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
                
                NavigationLink(destination: NavBarView(user: currentUser)) {
                    EmptyView()
                }
                .hidden()
                
                Button(action: {
                    self.createUser()
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
    }
    
    func createUser() {
        Task {
            let user = User(id_user: 0, firstName: firstname, lastName: lastname, sex: sex, company: company, biography: biography, id: 0)
            currentUser = user
            await userViewModel.addUser(for: user)
            UserDefaults.standard.set(id_user, forKey: "id_user")
            UserDefaults.standard.set(firstname, forKey: "firstname")
            UserDefaults.standard.set(lastname, forKey: "lastname")
            UserDefaults.standard.set(sex, forKey: "sex")
            UserDefaults.standard.set(company, forKey: "company")
            UserDefaults.standard.set(biography, forKey: "biography")
        }
    }
}

struct UserCreateView_Previews: PreviewProvider {
    static var previews: some View {
        UserCreateView()
    }
}
