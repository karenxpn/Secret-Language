//
//  ReportBirthdayPicker.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 30.06.21.
//

import SwiftUI

struct ReportBirthdayPicker: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let pickerData = [
        "January" : 31,
        "February" : 29,
        "March" : 31,
        "April" : 30,
        "May" : 31,
        "June" : 30,
        "July" : 31,
        "August" : 31,
        "September" : 30,
        "October" : 31,
        "November" : 30,
        "December" : 31
    ]
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    @Binding var month: String
    @Binding var day: Int

    var body: some View {
        
        ZStack {
            Background()
            
            VStack {
                
                Text( NSLocalizedString("chooseDate", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                
                Spacer()
                
                HStack( spacing: 0 ) {
                    Picker("", selection: $month) {
                        ForEach( months, id: \.self ) { value in
                            Text( value ).tag(value)
                                .foregroundColor(month == value ? .accentColor : .gray)
                                .font(.custom("times", size: 28))
                        }
                    }.labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: UIScreen.main.bounds.size.width * 0.47)
                    .compositingGroup()
                    .clipped()

                    Picker("", selection: $day) {
                        ForEach( 1...pickerData[month]!, id: \.self ) { day in
                            Text( "\(day)" ).tag(day)
                                .foregroundColor(self.day == day ? .accentColor : .gray)
                                .font(.custom("times", size: 28))
                        }
                    }.labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: UIScreen.main.bounds.size.width * 0.47)
                    .compositingGroup()
                    .clipped()
                }
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
        ReportBirthdayPicker( month: .constant("January"), day: .constant(1))
    }
}
