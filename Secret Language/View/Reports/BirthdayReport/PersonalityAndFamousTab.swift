//
//  PersonalityAndFamousTab.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI

struct PersonalityAndFamousTab: View {
    
    @Binding var selection: String
    var body: some View {
        HStack {
            VStack {
                
                Button {
                    withAnimation {
                        selection = "Personality"
                    }
                } label: {
                    Text( NSLocalizedString("personality", comment: "") )
                        .font(.custom("times", size: 16))
                        .foregroundColor(selection == "Personality" ? AppColors.accentColor : .systemGray3)
                        .padding(.top, 8)
                        .frame(width: UIScreen.main.bounds.size.width * 0.4)

                }
                
                if selection == "Personality" {
                    Capsule()
                        .fill(AppColors.accentColor)
                        .frame(width: UIScreen.main.bounds.size.width / 3, height: 2)
                }
            }
            
            VStack {
                
                Button {
                    withAnimation {
                        selection = "Famous"
                    }
                } label: {
                    Text( NSLocalizedString("famous", comment: "") )
                        .font(.custom("times", size: 16))
                        .foregroundColor(selection == "Personality" ? AppColors.accentColor : .systemGray3)
                        .padding(.top, 8)
                        .frame(width: UIScreen.main.bounds.size.width * 0.4)
                }
                
                if selection == "Famous" {
                    Capsule()
                        .fill(AppColors.accentColor)
                        .frame(width: UIScreen.main.bounds.size.width / 3, height: 2)
                }
            }
        }.padding(.horizontal)
    }
}

struct PersonalityAndFamousTab_Previews: PreviewProvider {
    static var previews: some View {
        PersonalityAndFamousTab(selection: .constant("Famous"))
    }
}
