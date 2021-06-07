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
                    
                    ForEach( authVM.moreGenders.filter { authVM.genderFilter.isEmpty ? true : $0.gender_name.localizedCaseInsensitiveContains(authVM.genderFilter)}, id: \.id ) { gender in
                        
                        Button(action: {
                            authVM.signUpGender = gender.gender_name
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text( gender.gender_name )
                                .foregroundColor(.white)
                                .font(.custom("Gilroy-Regular", size: 16))
                                .padding()
                        })

                    }.listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
            }
            
        }.navigationBarTitle(Text( "" ), displayMode: .inline)
        .navigationBarTitleView(AuthNavTitle(title: NSLocalizedString("iam", comment: "")), displayMode: .inline)
        .onAppear {
            // get all genders
            authVM.getAllGenders()
        }
    }
}

struct MoreGenders_Previews: PreviewProvider {
    static var previews: some View {
        MoreGenders()
            .environmentObject(AuthViewModel())
    }
}
