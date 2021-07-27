//
//  BirthdayPicker.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI

struct BirthdayPicker: View {
    
    @Binding var birthdayDate: Date
    @Environment(\.presentationMode) var presentationMode
    
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
        BirthdayPicker(birthdayDate: .constant(Date()))
            .environmentObject(AuthViewModel())
    }
}

