//
//  FilterMatches.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.06.21.
//

import SwiftUI

struct FilterMatches: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var matchesVM: MatchesViewModel
    var body: some View {
        
        NavigationView {
            ZStack {
                
                AppColors.dataFilterTopBg
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    
                    VStack( alignment: .leading) {
                        HStack {
                            ForEach( matchesVM.dataFilterGenders, id: \.self ) { gender in
                                
                                Spacer()
                                Button {
                                    matchesVM.dataFilterGender = gender
                                } label: {
                                    Text( gender )
                                        .font(.custom("times", size: 16))
                                        .foregroundColor(matchesVM.dataFilterGender == gender ? .accentColor : .systemGray3)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 18)
                                        .background(matchesVM.dataFilterGender == gender ? .black : AppColors.dataFilterGendersBg)
                                }
                                Spacer()
                            }
                        }
                        
                        Text( NSLocalizedString("categories", comment: ""))
                            .font(.custom("Gilroy-Regular", size: 12))
                            .foregroundColor(.gray)
                            .padding(.vertical)                        
                    }.padding()
                    
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
                    }.padding()
                    
                }.padding(.top, 1)
            }.navigationBarTitle("")
            .navigationBarTitleView(MatchesNavBar(title: NSLocalizedString("dataFilters", comment: "")), displayMode: .inline)
            .onAppear(perform: {
                // get genders
                // get all categories
                // get all ideal fors
            })
        }
    }
}

struct FilterMatches_Previews: PreviewProvider {
    static var previews: some View {
        FilterMatches()
            .environmentObject(MatchesViewModel())
    }
}
