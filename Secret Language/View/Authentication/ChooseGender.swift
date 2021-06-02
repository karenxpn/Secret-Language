//
//  ChooseGender.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 01.06.21.
//

import SwiftUI

struct ChooseGender: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        ZStack {
            Background()
            
            VStack( alignment: .leading, spacing: 20) {
                Text(NSLocalizedString("indicateGender", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                    .padding(.bottom)
                
                Text( NSLocalizedString("helpUs", comment: ""))
                    .foregroundColor(.accentColor)
                    .font(.custom("Gilroy-Regular", size: 14))
                
                TopGender(gender: NSLocalizedString("male", comment: ""))
                    .environmentObject(authVM)
                
                TopGender(gender: NSLocalizedString("female", comment: ""))
                    .environmentObject(authVM)
                
                TopGender(gender: NSLocalizedString("neutral", comment: ""))
                    .environmentObject(authVM)
                
                NavigationLink( destination: MoreGenders().environmentObject(authVM), label: {
                    
                    Text( NSLocalizedString("moreGenders", comment: "") )
                        .font(.custom("times", size: 16))
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(AppColors.boxColor)
                        .cornerRadius(15)
                })
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink( destination: ConnectionType().environmentObject(authVM), label: {
                        Image("proceed")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    }).disabled(authVM.signUpGender.isEmpty)
                }
                
            }.padding()
            
        }.navigationBarTitle(Text( NSLocalizedString("iam", comment: "") ), displayMode: .inline)
    }
}

struct ChooseGender_Previews: PreviewProvider {
    static var previews: some View {
        ChooseGender()
            .environmentObject(AuthViewModel())
    }
}
