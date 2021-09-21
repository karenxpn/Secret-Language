//
//  SettingsBirthdayPicker.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 27.07.21.
//

import SwiftUI

struct SettingsBirthdayPicker: View {
    
    @EnvironmentObject var settingsVM: SettingsViewModel
    @State var birthdayDate: Date
    @Binding var selectedBirthdayDate: Date
    
    let dateMinLimit = Calendar.current.date(byAdding: .year, value: -17, to: Date()) ?? Date()
    let dateMaxLimit = Calendar.current.date(byAdding: .year, value: -150, to: Date()) ?? Date()
    
    var body: some View {
        
        ZStack {
            Background()
            
            VStack {
                
                Text( NSLocalizedString("chooseBirthday", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                
                Spacer()
                DatePicker("", selection: $birthdayDate, in: dateMaxLimit...dateMinLimit ,displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .colorMultiply(AppColors.accentColor)
                    .environment(\.locale, Locale.init(identifier: "us"))

                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        selectedBirthdayDate = birthdayDate
                        settingsVM.updateFields(updatedFrom: "birthday")
                    }, label: {
                        Image("proceed")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    })
                }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)

            }.padding()
            .padding(.top, 50)
            
            CustomAlert(isPresented: $settingsVM.updateAlert, alertMessage: settingsVM.updateAlertMessage, alignment: .center)
                .offset(y: settingsVM.updateAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
        
        }
    }
}
