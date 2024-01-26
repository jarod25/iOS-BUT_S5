//
//  UserDetails.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 22/01/2024.
//

import SwiftUI

struct UserDetailsView: View {
    
    @State var user: User
    
    var body: some View {
            VStack(spacing: 8) {
                Text(user.firstName + " " + user.lastName)
                    .font(.title)
                    .foregroundColor(.black)
                
                Text(user.sex)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)

                Text(user.company)
                    .font(.title3)
                    .foregroundColor(.black)

                Text(user.biography)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
            
        }
}
