//
//  SettingsGenderPicker.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 27.07.21.
//

import SwiftUI

struct SettingsGenderPicker: View {
    
    @EnvironmentObject var settingsVM: SettingsViewModel
    @State var gender: GenderModel
    
    var body: some View {
        
        ZStack {
            Background()
            
            ScrollView {
                LazyVStack {
                    
                    ForEach( settingsVM.allGenders, id: \.id ) { gender in
                        
                        Button(action: {
                            self.gender = gender
                        }, label: {
                            Text( gender.gender_name )
                                .font(.custom("times", size: 16))
                                .foregroundColor(self.gender.id == gender.id ? .black : .white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(self.gender.id == gender.id ? .accentColor : AppColors.boxColor)
                                .cornerRadius(15)
                        })
                        
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            settingsVM.gender = gender
                            settingsVM.updateFields()
                        }, label: {
                            Image("proceed")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                        })
                    }
                }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
            }.padding(.top, 1)
        }.onAppear {
            settingsVM.getAllGenders()
        }
    }
}
