//
//  Settings.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 24.06.21.
//

import SwiftUI

struct Settings: View {
    
    @ObservedObject var settingsVM = SettingsViewModel()
    
    var body: some View {
        ZStack {
            Background()
            
            ScrollView {
                LazyVStack {
                    SettingsListCell(destination: AnyView(Text( "Gender" )), title: NSLocalizedString("gender", comment: ""), content: settingsVM.gender, navigationEnabled: true)
                    
                    SettingsListCell(destination: AnyView(Text( "Full Name" )), title: NSLocalizedString("fullName", comment: ""), content: settingsVM.fullName, navigationEnabled: true)
                    
                    SettingsListCell(destination: AnyView(Text( "Location" )), title: NSLocalizedString("location", comment: ""), content: settingsVM.location, navigationEnabled: false)
                    
                    SettingsListCell(destination: AnyView(Text( "Age" )), title: NSLocalizedString("age", comment: ""), content: settingsVM.birthday, navigationEnabled: true)
                }
            }.padding(.top, 1)


        }.navigationBarTitle("")
        .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("settings", comment: "")))
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
