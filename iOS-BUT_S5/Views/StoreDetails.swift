//
//  StoreDetails.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 22/01/2024.
//

import SwiftUI

struct StoreDetails: View {
    
    @StateObject var viewModel = UserViewModel(service: UserService())
    
    @State var store: Store
    @State var currentUser: User
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .success(data: let users):
                let userIsInStore = users.contains(currentUser)
                
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
                                    UserDetails(user: currentUser)
                                }
                                ForEach(users, id: \.self) { user in
                                    if (user != currentUser) {
                                        UserDetails(user: user)
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
            case .loading:
                ProgressView()
            default:
                Text("Une erreur est survenue")
            }
        }
    }
}

//struct StoreDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreDetails()
//    }
//}
