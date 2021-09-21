//
//  SettingsGenderPicker.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 27.07.21.
//

import SwiftUI

struct SettingsGenderPicker: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settingsVM: SettingsViewModel
    @State var gender: GenderModel
    
    var body: some View {
        
        ZStack {
            Background()
            
            if settingsVM.loadingGenders {
                ProgressView()
            } else {
                ScrollView( showsIndicators: false ) {
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
                                    .background(self.gender.id == gender.id ? AppColors.accentColor : AppColors.boxColor)
                                    .cornerRadius(15)
                            })
                        }
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                settingsVM.gender = gender
                                settingsVM.updateFields(updatedFrom: "gender")
                            }, label: {
                                Image("proceed")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                            })
                        }
                    }.padding()
                    .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                }.padding(.top, 1)
            }

            CustomAlert(isPresented: $settingsVM.updateAlert, alertMessage: settingsVM.updateAlertMessage, alignment: .center)
                .offset(y: settingsVM.updateAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.navigationBarItems(trailing: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image("close" )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .padding([.leading, .top, .bottom])
        })).onAppear {
            settingsVM.getAllGenders()
        }
    }
}
