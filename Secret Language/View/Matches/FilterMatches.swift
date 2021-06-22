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
                                ForEach( matchesVM.dataFilterGenders, id: \.id ) { gender in
                                    
                                    Spacer()
                                    Button {
                                        withAnimation {
                                            matchesVM.dataFilterGender = gender.id
                                        }
                                    } label: {
                                        Text( gender.gender_name )
                                            .font(.custom("times", size: 16))
                                            .foregroundColor(matchesVM.dataFilterGender == gender.id ? .accentColor : .systemGray3)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 18)
                                            .background(RoundedRectangle(cornerRadius: 4)
                                                            .strokeBorder(matchesVM.dataFilterGender == gender.id ? AppColors.accentColor : Color.clear, lineWidth: 1.5)
                                                            .background(matchesVM.dataFilterGender == gender.id ? .black : AppColors.dataFilterGendersBg)
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
                        
                        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
                        LazyVGrid(columns: columns, alignment: .leading, content: {
                            ForEach(matchesVM.categoryItems, id: \.self ) { item in

                                Button(action: {

                                    if matchesVM.selectedCategories.contains(item.name) {
                                        if let index = matchesVM.selectedCategories.firstIndex(of: item.name) {
                                            matchesVM.selectedCategories.remove(at: index)
                                        }
                                    } else {
                                        matchesVM.selectedCategories.append(item.name)
                                    }

                                }, label: {
                                    Text( item.name )
                                        .font(.custom("Gilroy-Regular", size: 14))
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 10)
                                        .background(RoundedRectangle(cornerRadius: 4)
                                                        .strokeBorder(matchesVM.selectedCategories.contains(item.name) ? AppColors.accentColor : Color.clear, lineWidth: 1.5)
                                                        .background(matchesVM.selectedCategories.contains(item.name) ? .black : AppColors.dataFilterCategoryItemBg)
                                        )
                                        .cornerRadius(5)
                                })
                            }
                        }).padding(.horizontal)
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                // perform api request and close the view
                                matchesVM.getMatches()
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
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("close")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                    .padding([.leading, .top, .bottom])
                
            }))
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