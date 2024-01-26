//
//  StoreDetails.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 22/01/2024.
//

import SwiftUI

struct StoreDetailsView: View {
    
    @StateObject var userViewModel: UserViewModel
    @State var store: Store
    @State private var showingPopup = false
    @State private var selectedUser: User?
    
    var body: some View {
        let currentUser: User = userViewModel.currentUser
        NavigationView {
            VStack {
                switch userViewModel.state {
                case .success(data: let users):
                    let userIsInStore = users.contains { $0.id_user == currentUser.id_user }
                    
                    VStack {
                        Spacer()
                        Spacer()
                        
                        Text(store.name)
                            .font(.title)
                        
                        Spacer()
                        
                        if (users.isEmpty) {
                            Text("Personne n'est présent")
                                .bold()
                        }
                        else {
                            Text("Personnes présentes :")
                                .bold()
                            ZStack {
                                ScrollView {
                                    VStack(spacing: 10) {
                                        if userIsInStore {
                                            Button(action: {
                                                self.selectedUser = currentUser
                                                self.showingPopup = true
                                            }) {
                                                UserCardView(user: currentUser)
                                                    .padding()
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                    .background(Color.white.opacity(0.95))
                                                    .cornerRadius(10)
                                                    .shadow(radius: 5)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                                                    )
                                                    .padding(.horizontal)
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                            }
                                        }
                                        ForEach(users.filter { $0.id_user != currentUser.id_user }, id: \.self) { user in
                                            Button(action: {
                                                self.selectedUser = user
                                                self.showingPopup = true
                                            }) {
                                                UserCardView(user: user)
                                                    .padding()
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                    .background(Color.white.opacity(0.95))
                                                    .cornerRadius(10)
                                                    .shadow(radius: 5)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color.gray, lineWidth: 2)
                                                    )
                                                    .padding(.horizontal)
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                if showingPopup && (selectedUser != nil) {
                                    ZStack {
                                        Color.white.opacity(0.95)
                                            .edgesIgnoringSafeArea(.all)
                                            .zIndex(1)

                                        UserDetailsView(user: selectedUser!)
                                            .frame(width: 300, height: 400)
                                            .background(Color.white)
                                            .cornerRadius(12)
                                            .shadow(radius: 10)
                                            .overlay(
                                                Button(action: {
                                                    showingPopup = false
                                                }) {
                                                    Image(systemName: "xmark.circle.fill")
                                                        .padding()
                                                        .foregroundColor(.gray)
                                                },
                                                alignment: .topTrailing
                                            )
                                            .zIndex(2)
                                        }
                                        .transition(.scale)
                                    }
                                }
                                .animation(.default, value: showingPopup)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        if(!showingPopup) {
                            Button(action: {
                                if(userIsInStore) {
                                    self.deleteLocation()
                                }
                                else {
                                    self.addLocation()
                                }
                            }) {
                                Text(userIsInStore ? "Je n'y suis plus" : "J'y suis")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: 150)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(40)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                case .loading:
                    ProgressView()
                default:
                    Text("Une erreur est survenue")
                }
            }
            .task {
                await userViewModel.getUserByStores(for: store.id)
            }
        }
    }
    
    func addLocation() {
        Task {
            await userViewModel.addUserToStore(for: userViewModel.currentUser.id_user, id_store: store.id)
            await userViewModel.getUserByStores(for: store.id)
        }
    }
    
    func deleteLocation() {
        Task {
            await userViewModel.removeUserFromStore(for: userViewModel.currentUser.id_user)
            await userViewModel.getUserByStores(for: store.id)
        }
    }
}
