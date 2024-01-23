//
//  NavBarView.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI

struct NavBarView: View {
    
    var user: User
    
    var body: some View {
            NavigationView {
                MapView(currentUser: user)
//                Color.clear // Placeholder pour le contenu de la vue, invisible
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                NavigationLink(destination: UserEditView(user: user)) {
                                    EmptyView()
                                }
                                .hidden()
                                
                            
                            }) {
                                Text("Profil")
                                Image(systemName: "person.crop.circle")
                                    .imageScale(.large)
                            }
                        }
                    }
            }
        }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView(user: User(id_user: 0, firstName: "", lastName: "", sex: "", company: "", biography: "", id: 0))
    }
}
