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
        
        ZStack {
            Background()
            
            VStack {
                
                Text( NSLocalizedString("chooseBirthday", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                
                Spacer()
                DatePicker("", selection: $authVM.birthdayDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .colorMultiply(.accentColor)
                Spacer()
                
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("proceed")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    })
                }

            }.padding()
            .padding(.top, 50)
        }
        
    }
}

struct BirthdayPicker_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayPicker()
    }
}

