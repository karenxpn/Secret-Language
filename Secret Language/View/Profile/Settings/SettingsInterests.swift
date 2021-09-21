//
//  SettingsInterests.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 07.09.21.
//

import SwiftUI

struct SettingsInterests: View {
    
    @EnvironmentObject var settingsVM: SettingsViewModel
    @State private var selectedInterest: Int = 0
    
    var body: some View {
        
        ZStack {
            Background()
            
            if settingsVM.loadingInterests {
                ProgressView()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach( settingsVM.allInterests, id: \.id ) { interest in
                            Button(action: {
                                selectedInterest = interest.id
                            }, label: {
                                VStack {
                                    Text( interest.name )
                                        .foregroundColor(selectedInterest == interest.id ? .black : .white)
                                        .font(.custom("times", size: 16))

                                    Text( interest.description )
                                        .foregroundColor(Color(UIColor(red: 55/255, green: 66/255, blue: 77/255, alpha: 1)))
                                        .font(.custom("Avenir", size: 10))
                                }.frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(selectedInterest == interest.id ? AppColors.accentColor : AppColors.boxColor)
                                .cornerRadius(15)
                            })
                        }
                        
                        Spacer()
                        
                        
                        HStack {
                            Spacer()

                            Button(action: {
                                settingsVM.interestedIn = selectedInterest
                                settingsVM.updateFields(updatedFrom: "interestedIn")
                            }, label: {
                                Image("proceed")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                            })
                        }
                    }.padding()
                    .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                }.padding(.top, 1)
            }
            
        }.onAppear {
            selectedInterest = settingsVM.interestedIn
            settingsVM.getAllInterests()
        }
    }
}

struct SettingsInterests_Previews: PreviewProvider {
    static var previews: some View {
        SettingsInterests()
    }
}
