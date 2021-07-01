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
    
    @Binding var month: String
    @Binding var day: Int

    var body: some View {
        
        ZStack {
            Background()
            
            VStack {
                
                Text( NSLocalizedString("chooseBirthday", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                
                Spacer()
                
                HStack {
                    Picker("", selection: $month) {
                        ForEach( pickerData.sorted(by: >), id: \.key ) { key, value in
                            Text( key ).tag(key)
                                .foregroundColor(.accentColor)
                        }
                    }.labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: UIScreen.main.bounds.size.width * 0.47)
                    .compositingGroup()
                    .clipped()

                    Picker("", selection: $day) {
                        ForEach( 1...pickerData[month]!, id: \.self ) { day in
                            Text( "\(day)" ).tag(day)
                                .foregroundColor(.accentColor)
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
