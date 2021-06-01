//
//  MoreGenders.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 01.06.21.
//

import SwiftUI

struct MoreGenders: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        ZStack {
            Background()
            
            List {
                // search field
                
                ForEach( authVM.moreGenders, id: \.self ) { gender in
                    
                    Button(action: {
                        authVM.signUpGender = gender
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text( gender )
                            .foregroundColor(.white)
                            .font(.custom("Gilroy-Regular", size: 16))
                    })

                }.listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            
        }.navigationBarTitle(Text( NSLocalizedString("iam", comment: "")), displayMode: .inline)
        .onAppear {
            // get all genders
        }
    }
}

struct MoreGenders_Previews: PreviewProvider {
    static var previews: some View {
        MoreGenders()
            .environmentObject(AuthViewModel())
    }
}
