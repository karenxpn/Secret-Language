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
                
                if matchesVM.loadingFilter {
                    ProgressView()
                } else {
                    ScrollView {
                        
                        VStack( alignment: .leading) {
                            HStack {
                                ForEach( matchesVM.dataFilterGenders, id: \.self ) { gender in
                                    
                                    Spacer()
                                    Button {
                                        withAnimation {
                                            matchesVM.dataFilterGender = gender
                                        }
                                    } label: {
                                        Text( gender )
                                            .font(.custom("times", size: 16))
                                            .foregroundColor(matchesVM.dataFilterGender == gender ? .accentColor : .systemGray3)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 18)
                                            .background(RoundedRectangle(cornerRadius: 4)
                                                            .strokeBorder(matchesVM.dataFilterGender == gender ? AppColors.accentColor : Color.clear, lineWidth: 1.5)
                                                            .background(matchesVM.dataFilterGender == gender ? .black : AppColors.dataFilterGendersBg)
                                                            )
                                            
                                    }
                                    Spacer()
                                }
                            }
                            
                            Text( NSLocalizedString("categories", comment: ""))
                                .font(.custom("Gilroy-Regular", size: 12))
                                .foregroundColor(.gray)
                                .padding(.vertical)
                            
                            HStack {
                                ForEach( matchesVM.dataFilterCategories, id: \.id ) { category in
                                    
                                    Spacer()
                                    
                                    VStack( spacing: 4) {
                                        
                                        Button {
                                            withAnimation {
                                                matchesVM.dataFilterCategory = category.id
                                            }
                                        } label: {
                                            Text( category.name )
                                                .font(.custom("times", size: 16))
                                                .foregroundColor(matchesVM.dataFilterCategory == category.id ? .accentColor : .systemGray3)
                                                .padding(.top, 8)
                                        }
                                        
                                        if matchesVM.dataFilterCategory == category.id {
                                            Capsule()
                                                .fill(AppColors.accentColor)
                                                .frame(width: UIScreen.main.bounds.size.width / 5, height: 2)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            
                            
                            Text( NSLocalizedString("idealForOptional", comment: ""))
                                .font(.custom("times", size: 16))
                                .foregroundColor(.gray)
                                .padding(.top)
                        }.padding()

                        
                        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
                        LazyVGrid(columns: columns, alignment: .leading, content: {
                            ForEach(matchesVM.categoryItems, id: \.id ) { item in

                                Button(action: {

                                }, label: {
                                    Text( item.name )
                                        .font(.custom("Gilroy-Regular", size: 14))
                                        .padding(.vertical, 6)
                                        .padding(.horizontal)
                                        .background(AppColors.dataFilterCategoryItemBg)
                                        .cornerRadius(5)
                                })
                            }
                        }).padding(.horizontal)
                        
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
                }
            
            }.navigationBarTitle("")
            .navigationBarTitleView(MatchesNavBar(title: NSLocalizedString("dataFilters", comment: "")), displayMode: .inline)
            .onAppear(perform: {
                matchesVM.getFilterCategoriesWithItems()
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
