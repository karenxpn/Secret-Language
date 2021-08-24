//
//  SettingsGenderPreferencePicker.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.08.21.
//

import SwiftUI

struct SettingsGenderPreferencePicker: View {
    
    @EnvironmentObject var settingsVM: SettingsViewModel
    let genders = [GenderModel(id: 1, gender_name: "Male"),
                   GenderModel(id: 2, gender_name: "Female"),
                   GenderModel(id: 0, gender_name: "Everyone")]
    
    @State var preference: Int
        
    var body: some View {
        ZStack {
            Background()
            
            VStack( alignment: .leading, spacing: 20 ) {
                
                Text(NSLocalizedString("whatIsGenderPreference", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                    .padding(.bottom)
                
                Text( NSLocalizedString("chooseModel", comment: ""))
                    .foregroundColor(.accentColor)
                    .font(.custom("Gilroy-Regular", size: 14))
                
                ForEach( genders, id: \.id ) { gender in
                    Button(action: {
                        preference = gender.id
                    }, label: {
                        VStack {
                            Text( gender.gender_name )
                                .foregroundColor(preference == gender.id ? .black : .white)
                                .font(.custom("times", size: 16))
                            
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(preference == gender.id ? .accentColor : AppColors.boxColor)
                        .cornerRadius(15)
                    })
                }
                                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        settingsVM.genderPreference = preference
                        settingsVM.updateFields(updatedFrom: "preferences")
                    }, label: {
                        Image("proceed")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    })
                }
                
                Spacer()
                                
            }.padding()
        }
    }
}

struct SettingsGenderPreferencePicker_Previews: PreviewProvider {
    static var previews: some View {
        SettingsGenderPreferencePicker(preference: 1)
    }
}
