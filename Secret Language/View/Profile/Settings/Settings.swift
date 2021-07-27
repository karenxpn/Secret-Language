//
//  Settings.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 24.06.21.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var settingsVM = SettingsViewModel()
    @State private var showForm: Bool = false
    
    var body: some View {
        ZStack {
            Background()
            
            if settingsVM.loading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVStack {

                        Button {
                            settingsVM.navigateToGenders.toggle()
                        } label: {
                            SettingsListCell(title: NSLocalizedString("gender", comment: ""), content: settingsVM.gender.gender_name)
                        }.background(
                            
                            ZStack {
                                NavigationLink(destination: EmptyView()) {
                                    EmptyView()
                                }
                                
                                NavigationLink(destination: SettingsGenderPicker(gender: settingsVM.gender)
                                                .environmentObject(settingsVM),
                                               isActive: $settingsVM.navigateToGenders) {
                                    EmptyView()
                                }.hidden()
                            }
                        )

                        Button {
                            showForm.toggle()
                        } label: {
                            HStack {
                                VStack( alignment: .leading, spacing: 5) {
                                    Text( NSLocalizedString("fullName", comment: "") )
                                        .foregroundColor(.gray)
                                        .font(.custom("Gilroy-Regular", size: 10))
                                    
                                    Text( settingsVM.fullName )
                                        .foregroundColor(.white)
                                        .font(.custom("times", size: 20))
                                        .fontWeight(.semibold)
                                    
                                    Divider()
                                }
                                
                                Image( "rightArrow" )
                            }.padding()
                        }
                        
                        SettingsListCell( title: NSLocalizedString("location", comment: ""), content: settingsVM.location)
                        
                        Button {
                            settingsVM.navigateToBirthdayPicker.toggle()
                        } label: {
                            SettingsListCell( title: NSLocalizedString("age", comment: ""),
                                              content: settingsVM.dateFormatter.string(from: settingsVM.birthdayDate))
                        }.background(
                            
                            ZStack {
                                
                                NavigationLink(destination: EmptyView()) {
                                    EmptyView()
                                }
                                
                                NavigationLink(destination: SettingsBirthdayPicker(birthdayDate: settingsVM.birthdayDate,
                                                                                   selectedBirthdayDate: $settingsVM.birthdayDate)
                                                .environmentObject(settingsVM),
                                               isActive: $settingsVM.navigateToBirthdayPicker) {
                                    EmptyView()
                                }.hidden()
                            }
                        )
                                                
                        Button {
                            settingsVM.logout()
                        } label: {
                            Text( "Log Out" )
                                .foregroundColor(.black)
                                .font(.custom("Avenir", size: 18))
                                .frame(width: UIScreen.main.bounds.size.width * 0.9, height: 50)
                                .background(.accentColor)
                                .cornerRadius(25)
                        }
                    }
                }.padding(.top, 1)
            }
            
            CustomAlert(isPresented: $settingsVM.showAlert, alertMessage: settingsVM.alertMessage, alignment: .center)
                .offset(y: settingsVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.navigationBarTitle("")
        .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("settings", comment: "")))
        .alert(isPresented: $showForm, TextFieldAlert(title: NSLocalizedString("fullName", comment: ""), message: "") { (text) in
            if text != nil && ( text?.count ?? 0 ) >= 3 && ( text?.count ?? 0 ) < 20 {
                settingsVM.fullName = text!
                settingsVM.updateFields(updatedFrom: "")
            }
        })
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
