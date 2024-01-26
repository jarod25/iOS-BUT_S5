//
//  NavBarView.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI

struct NavBarView: View {
    
    @StateObject var userViewModel: UserViewModel
    
    @State private var isRedirecting = false
        
    var body: some View {
        MapView(userViewModel: userViewModel)
            .background(
                NavigationLink(destination: UserEditView(userViewModel: userViewModel), isActive: $isRedirecting) {
                    EmptyView()
                }
                .hidden()
                .navigationBarBackButtonHidden(true)
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(height: 30)

                        HStack {
                            Button(action: {
                                isRedirecting = true
                            }) {
                                Text("Profil")
                                    .foregroundColor(.blue)
                                Image(systemName: "person.crop.circle")
                                    .imageScale(.large)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .task {
                self.addIdUser()
            }
    }

    
    func addIdUser() {
        Task {
            let user_id = await userViewModel.getLastUserId()
            let user = User(id_user: user_id, firstName: userViewModel.currentUser.firstName, lastName: userViewModel.currentUser.lastName, sex: userViewModel.currentUser.sex, company: userViewModel.currentUser.company, biography: userViewModel.currentUser.biography, id: 0)
            userViewModel.currentUser = user
            await userViewModel.updateUser(for: user, id_user: user_id)
        }
    }
}

