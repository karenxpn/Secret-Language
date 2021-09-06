//
//  SearchFilter.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 05.09.21.
//

import SwiftUI

struct SearchFilter: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var searchVM: SearchViewModel
    
    @State private var chosenGender: Int = 0
    @State private var chosenCategory: Int = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Background()
                
                ZStack( alignment: .bottomTrailing ) {
                    
                    ScrollView {
                        
                        VStack( alignment: .leading) {
                            HStack {
                                ForEach( searchVM.dataFilterGenders, id: \.id ) { gender in
                                    
                                    Spacer()
                                    Button {
                                        withAnimation {
                                            chosenGender = gender.id
                                        }
                                    } label: {
                                        Text( gender.gender_name )
                                            .font(.custom("times", size: 16))
                                            .foregroundColor(chosenGender == gender.id ? .accentColor : .systemGray3)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 18)
                                            .background(RoundedRectangle(cornerRadius: 4)
                                                            .strokeBorder(chosenGender == gender.id ? AppColors.accentColor : Color.clear, lineWidth: 1.5)
                                                            .background(chosenGender == gender.id ? .black : AppColors.boxColor)
                                            )
                                    }
                                    Spacer()
                                }
                            }
                            
                            Text( NSLocalizedString("categories", comment: ""))
                                .font(.custom("Gilroy-Regular", size: 12))
                                .foregroundColor(.gray)
                                .padding(.vertical)
                            
                            VStack {
                                ForEach( searchVM.dataFilterCategories, id: \.id ) { category in
                                    
                                    Button {
                                        chosenCategory = category.id
                                    } label: {
                                        VStack {
                                            Text( category.name )
                                                .foregroundColor(chosenCategory == category.id ? .black : .white)
                                                .font(.custom("times", size: 16))
                                            
                                            Text( category.description )
                                                .foregroundColor(Color(UIColor(red: 55/255, green: 66/255, blue: 77/255, alpha: 1)))
                                                .font(.custom("Avenir", size: 10))
                                        }.frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .background(chosenCategory == category.id ? .accentColor : AppColors.boxColor)
                                        .cornerRadius(15)
                                    }
                                }
                            }
                        }.padding()
                        
                    }.padding(.top, 1)
                    
                    Button(action: {
                        // perform api request and close the view
                        searchVM.dataFilterGender = chosenGender
                        searchVM.dataFilterCategory = chosenCategory
                        searchVM.getSearchUsers(search: searchVM.search)
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("proceed")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    }).padding()
                }
            }.navigationBarTitle("")
            .navigationBarTitleView(MatchesNavBar(title: NSLocalizedString("searchFilter", comment: "")), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("close")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                    .padding([.leading, .top, .bottom])
            })).onAppear {
                chosenGender = searchVM.dataFilterGender
                chosenCategory = searchVM.dataFilterCategory
            }
        }
    }
}

struct SearchFilter_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilter()
    }
}
