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

    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        ZStack {
            Background()
            
            if authVM.loadingGenders {
                ProgressView()
            } else {
                List {
                    // search field
                    
                    TextField(NSLocalizedString("search", comment: ""), text: $authVM.genderFilter)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25).fill(AppColors.boxColor))
                        .padding()
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                    
                    
                    ForEach( authVM.moreGenders.filter { authVM.genderFilter.isEmpty ? true : $0.localizedCaseInsensitiveContains(authVM.genderFilter)}, id: \.self ) { gender in
                        
                        Button(action: {
                            authVM.signUpGender = gender
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text( gender )
                                .foregroundColor(.white)
                                .font(.custom("Gilroy-Regular", size: 16))
                                .padding()
                        })

                    }.listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }

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
