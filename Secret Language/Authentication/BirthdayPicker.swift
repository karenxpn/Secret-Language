//
//  BirthdayPicker.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI

struct BirthdayPicker: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Background()
                
                DatePicker("", selection: $authVM.birthdayDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .colorMultiply(.accentColor)
            }.navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text( "Save" )
            }))
        }

    }
}

struct BirthdayPicker_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayPicker()
    }
}

