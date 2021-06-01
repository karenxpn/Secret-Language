//
//  TopGender.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 01.06.21.
//

import SwiftUI

struct TopGender: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    let gender: String
    
    var body: some View {
        
        Button(action: {
            authVM.signUpGender = gender
        }, label: {
            HStack {
                Spacer()
                
                Text( gender )
                    .font(.custom("times", size: 16))
                    .foregroundColor(authVM.signUpGender == gender ? .black : .white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.vertical)
                    .background(authVM.signUpGender == gender ? .accentColor : AppColors.boxColor)
                    .cornerRadius(15)
                Spacer()
            }
        })
    }
}

struct TopGender_Previews: PreviewProvider {
    static var previews: some View {
        TopGender( gender: "I'm Male")
            .environmentObject(AuthViewModel())
    }
}
