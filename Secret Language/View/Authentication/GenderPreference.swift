//
//  GenderPreference.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 24.08.21.
//

import SwiftUI

struct GenderPreference: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    let genders = [GenderModel(id: 1, gender_name: "Male"),
                   GenderModel(id: 2, gender_name: "Female"),
                   GenderModel(id: 0, gender_name: "Everyone")]
    
    var body: some View {
        ZStack {
            Background()
            
            VStack( alignment: .leading, spacing: 20 ) {
                Text(NSLocalizedString("whatIsGenderPreference", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                    .padding(.bottom)
                
                Text( NSLocalizedString("chooseModel", comment: ""))
                    .foregroundColor(AppColors.accentColor)
                    .font(.custom("Gilroy-Regular", size: 14))
                
                ForEach( genders, id: \.id ) { gender in
                    Button(action: {
                        authVM.genderPreference = gender.id
                    }, label: {
                        VStack {
                            Text( gender.gender_name )
                                .foregroundColor(authVM.genderPreference == gender.id ? .black : .white)
                                .font(.custom("times", size: 16))
                            
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(authVM.genderPreference == gender.id ? AppColors.accentColor : AppColors.boxColor)
                        .cornerRadius(15)
                    })
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        authVM.signUp()
                    }, label: {
                        Image("proceed")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    }).disabled(authVM.connectionType == nil)
                }
                
            }.padding()
        }.navigationBarTitle(Text( "" ), displayMode: .inline)
        .navigationBarTitleView(AuthNavTitle(title: NSLocalizedString("interestedIn", comment: "")), displayMode: .inline)
    }
}

struct GenderPreference_Previews: PreviewProvider {
    static var previews: some View {
        GenderPreference()
            .environmentObject(AuthViewModel())
    }
}
