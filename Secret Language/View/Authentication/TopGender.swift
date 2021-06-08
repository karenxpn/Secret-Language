//
//  TopGender.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 01.06.21.
//

import SwiftUI

struct TopGender: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    let gender: GenderModel
    
    var body: some View {
        
        Button(action: {
            authVM.signUpGender = gender.id
        }, label: {            
            Text( gender.gender_name )
                .font(.custom("times", size: 16))
                .foregroundColor(authVM.signUpGender == gender.id ? .black : .white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(authVM.signUpGender == gender.id ? .accentColor : AppColors.boxColor)
                .cornerRadius(15)
        })
    }
}

struct TopGender_Previews: PreviewProvider {
    static var previews: some View {
        TopGender( gender: GenderModel(id: 1, gender_name: "male"))
            .environmentObject(AuthViewModel())
    }
}
