//
//  Settings.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 24.06.21.
//

import SwiftUI

enum FormType {
    case name
    case instagram
}

enum SettingsAlertType: Identifiable {
    var id: Self { self }
    case logout
    case deactivate
}

struct Settings: View {
    @ObservedObject var settingsVM = SettingsViewModel()
    @State private var showForm: Bool = false
    @State private var formType: FormType? = .none
    @State private var alertType: SettingsAlertType? = .none
    
    var body: some View {
        ZStack {
            Background()
            
            if settingsVM.loading {
                ProgressView()
            } else {
                ScrollView( showsIndicators: false ) {
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
                        
                        Button(action: {
                            settingsVM.navigateToGenderPreferencePicker.toggle()
                        }, label: {
                            SettingsListCell(title: NSLocalizedString("genderPreference", comment: ""), content: settingsVM.genderPreferenceText)
                        }).background(
                            
                            ZStack {
                                
                                NavigationLink(destination: EmptyView()) {
                                    EmptyView()
                                }
                                
                                NavigationLink(destination: SettingsGenderPreferencePicker(preference: settingsVM.genderPreference).environmentObject(settingsVM),
                                               isActive: $settingsVM.navigateToGenderPreferencePicker) {
                                    EmptyView()
                                }.hidden()
                            }
                        )
                        
                        
                        Button(action: {
                            settingsVM.navigateToInterests.toggle()
                        }, label: {
                            SettingsListCell(title: NSLocalizedString("interestedIn", comment: ""), content: settingsVM.interestedInText)
                        }).background(
                            
                            ZStack {
                                
                                NavigationLink(destination: EmptyView()) {
                                    EmptyView()
                                }
                                
                                NavigationLink(destination: SettingsInterests().environmentObject(settingsVM),
                                               isActive: $settingsVM.navigateToInterests) {
                                    EmptyView()
                                }.hidden()
                            }
                        )
                        
                        Button {
                            formType = .name
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
                        
                        Button {
                            settingsVM.navigateToLocation.toggle()
                        } label: {
                            SettingsListCell( title: NSLocalizedString("location", comment: ""), content: settingsVM.location)
                        }.disabled(!settingsVM.canEditLocation)
                        .background (
                            ZStack {
                                
                                NavigationLink(destination: EmptyView()) {
                                    EmptyView()
                                }
                                
                                NavigationLink(destination: SettingsLocation()
                                                .environmentObject(settingsVM),
                                               isActive: $settingsVM.navigateToLocation) {
                                    EmptyView()
                                }.hidden()
                            }
                        )
                        
                        
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
                            formType = .instagram
                            showForm.toggle()
                        } label: {
                            HStack {
                                VStack( alignment: .leading, spacing: 5) {
                                    Text( NSLocalizedString("instagramUsername", comment: "") )
                                        .foregroundColor(.gray)
                                        .font(.custom("Gilroy-Regular", size: 10))
                                    
                                    Text( settingsVM.instagramUsername )
                                        .foregroundColor(.white)
                                        .font(.custom("times", size: 20))
                                    
                                    Divider()
                                }
                                
                                Image( "rightArrow" )
                            }.padding()
                        }
                        
                        Button {
                            alertType = .logout
//                            settingsVM.logout()
                        } label: {
                            Text( "Log Out" )
                                .foregroundColor(AppColors.accentColor)
                                .font(.custom("Avenir", size: 18))
                                .frame(height: 50)
                        }.padding(.bottom)
                        
                        Button {
                            alertType = .deactivate
                        } label: {
                            Text( "Deactivate account" )
                                .foregroundColor(.red)
                                .font(.custom("Avenir", size: 18))
                                .frame(width: UIScreen.main.bounds.size.width * 0.9, height: 50)
                                .background(RoundedRectangle(cornerRadius: 25).stroke(Color.red, lineWidth: 2))
                                .cornerRadius(25)
                        }.padding(.bottom)
                        
                        AllRightsReservedMadeByDoejo()
                            .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                    }
                }.padding(.top, 1)
            }
            
            CustomAlert(isPresented: $settingsVM.showAlert, alertMessage: settingsVM.alertMessage, alignment: .center)
                .offset(y: settingsVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.navigationBarTitle("")
        .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("settings", comment: "")))
        .onAppear(perform: {
            settingsVM.getSettingsFields()
        })
        .alert(isPresented: $showForm, self.formType == .name ?
                TextFieldAlert(title: NSLocalizedString("fullName", comment: ""), message: "") { (text) in
                    if text != nil && ( text?.count ?? 0 ) >= 2 && ( text?.count ?? 0 ) <= 40 {
                        settingsVM.fullName = text!
                        settingsVM.updateFields(updatedFrom: "")
                    }
               } :
                TextFieldAlert(title: NSLocalizedString("instagramUsername", comment: ""), message: "") { (text) in
                    if text != nil {
                        settingsVM.instagramUsername = text!
                        settingsVM.updateFields(updatedFrom: "")
                    }
               })
        .alert(item: $alertType, content: { value in
            
            if value == .deactivate {
                return Alert(title: Text( NSLocalizedString("accountDeactivation", comment: "") ),
                             message: Text( NSLocalizedString("areYouSureToDeactivate", comment: "") ),
                             primaryButton: .destructive(Text( "Deactivate" ), action: {
                    settingsVM.deactivateAccount()
                }), secondaryButton: .default(Text( "Cancel" )))
            } else {
                return Alert(title: Text( NSLocalizedString("logOutAlertTitle", comment: "") ),
                             message: Text( NSLocalizedString("areYouSureToLogOut", comment: "") ),
                             primaryButton: .destructive(Text( "Log Out" ), action: {
                    settingsVM.logout()
                }), secondaryButton: .default(Text( "Cancel" )))
            }
        })
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
