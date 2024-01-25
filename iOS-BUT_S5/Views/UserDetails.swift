//
//  UserDetails.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 22/01/2024.
//

import SwiftUI

struct UserDetails: View {
    
    @State var user: User
    
    var body: some View {
            VStack(spacing: 8) {
                Text(user.firstName + " " + user.lastName)
                    .font(.title)
                    .foregroundColor(.black)

                Text(user.company)
                    .font(.title3)
                    .foregroundColor(.black)

                Text(user.biography)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
            
        }
}

struct UserDetails_Previews: PreviewProvider {
    static var previews: some View {
        UserDetails(user: User(id_user: 0, firstName: "John", lastName: "Doe", sex: "", company: "ABC Corp.", biography: "ouai ouai", id: 0))
    }
}
