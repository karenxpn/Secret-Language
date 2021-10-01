//
//  ReportBirthdayPicker.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 30.06.21.
//

import SwiftUI

struct ReportBirthdayPicker: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var showYear: Bool = false
    @State private var localYear: Int = 1
    
    @State private var pickerData = [
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
    @Binding var year: Int?

    var body: some View {
        
        ZStack {
            Background()
            
            VStack {
                
                Text( NSLocalizedString("chooseDate", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                
                HStack {
                    Button {
                        withAnimation {
                            showYear = false
                        }
                        localYear = 1
                    } label: {
                        Text( "Hide Year" )
                            .foregroundColor(showYear ? Color.white : Color.black )
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .background(RoundedRectangle(cornerRadius: 25)
                                            .fill(showYear ? Color.clear : AppColors.accentColor))
                            .font(.custom("times", size: 16))
                    }
                    
                    Button {
                        withAnimation {
                            showYear = true
                        }
                        localYear = 2000
                    } label: {
                        Text( "Show Year" )
                            .foregroundColor(showYear ? Color.black : Color.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .background(RoundedRectangle(cornerRadius: 25)
                                            .fill(showYear ? AppColors.accentColor : Color.clear))
                            .font(.custom("times", size: 16))
                            
                    }
                }
                
                Spacer()
                
                HStack( spacing: 0 ) {
                    Picker("", selection: $month) {
                        ForEach( months, id: \.self ) { value in
                            Text( value ).tag(value)
                                .foregroundColor(month == value ? AppColors.accentColor : .gray)
                                .font(.custom("times", size: 30))
                        }
                    }.labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: UIScreen.main.bounds.size.width * ( showYear ? 0.33 : 0.47))
                    .compositingGroup()
                    .clipped()

                    Picker("", selection: $day) {
                        ForEach( 1...( ( localYear % 4 == 0  && month == "February") ? pickerData[month]! - 1 : pickerData[month]!), id: \.self ) { day in
                            Text( "\(day)" ).tag(day)
                                .foregroundColor(self.day == day ? AppColors.accentColor : .gray)
                                .font(.custom("times", size: 30))
                        }
                    }.labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: UIScreen.main.bounds.size.width * ( showYear ? 0.33 : 0.47))
                    .compositingGroup()
                    .clipped()
                    
                    if showYear {
                        Picker("", selection: $localYear) {
                            ForEach( 1700...2027, id: \.self ) { value in
                                Text( "\(value)" ).tag(value)
                                    .foregroundColor(localYear == value ? AppColors.accentColor : .gray)
                                    .font(.custom("times", size: 30))
                            }
                        }.labelsHidden()
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: UIScreen.main.bounds.size.width * 0.33)
                        .compositingGroup()
                        .clipped()
                    }
                }
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        year = showYear ? localYear : nil
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
        }.onAppear {
            if year != nil {
                localYear = year!
                showYear = true
            }
        }
    }
}

struct ReportBirthdayPicker_Previews: PreviewProvider {
    static var previews: some View {
        ReportBirthdayPicker( month: .constant("January"), day: .constant(1), year: .constant(nil))
    }
}
