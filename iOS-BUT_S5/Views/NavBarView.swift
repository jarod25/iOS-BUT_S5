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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isRedirecting = true
                    }) {
                        Text("Profil")
                        Image(systemName: "person.crop.circle")
                            .imageScale(.large)
                    }
                }
            }
            .background(
                NavigationLink(destination: UserEditView(userViewModel: userViewModel), isActive: $isRedirecting) {
                    EmptyView()
                }
                .hidden()
                .navigationBarBackButtonHidden(true)
            )
    }
}

