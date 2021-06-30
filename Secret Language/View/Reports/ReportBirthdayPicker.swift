//
//  ReportBirthdayPicker.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 30.06.21.
//

import SwiftUI

struct ReportBirthdayPicker: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var date: Date
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
                DatePicker("", selection: $date, in: dateMaxLimit...dateMinLimit ,displayedComponents: .date)
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

struct ReportBirthdayPicker_Previews: PreviewProvider {
    static var previews: some View {
        ReportBirthdayPicker( date: .constant(Date()))
    }
}
