//
//  StoreDetails.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 22/01/2024.
//

import SwiftUI

struct StoreDetails: View {
    
    @StateObject var userViewModel: UserViewModel

    @State var store: Store
    
    var body: some View {
        VStack {
            switch userViewModel.state {
            case .success(data: let users):
                let userIsInStore = users.contains(userViewModel.currentUser)
                
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
                        
                        ScrollView(.horizontal) {
                            HStack {
                                if (userIsInStore) {
                                    UserDetails(user: userViewModel.currentUser)
                                }
                                ForEach(users, id: \.self) { user in
                                    if (user != userViewModel.currentUser) {
                                        UserDetails(user: user)
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    Button(action: {
                        if(userIsInStore) {
                            self.deleteLocation()
                        }
                        else {
                            addLocation()
                        }
                    }) {
                        Text(userIsInStore ? "J'y suis" : "Je n'y suis plus")
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

//struct StoreDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreDetails()
//    }
//}
