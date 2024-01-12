//
//  NavBarView.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI

struct NavBarView: View {
    var body: some View {
            NavigationView {
                HomeView()
//                Color.clear // Placeholder pour le contenu de la vue, invisible
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
//                                UserEditView(user: User)
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
        NavBarView()
    }
}
