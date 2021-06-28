//
//  Search.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct Search: View {
    @ObservedObject var searchVM = SearchViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                
                ScrollView( showsIndicators: false ) {
                    VStack ( alignment: .leading, spacing: 20 ){
                        HStack {
                            
                            TextField(NSLocalizedString("globalSearch", comment: ""), text: $searchVM.search)
                                .font(.custom("Gilroy-Regular", size: 14))
                                .frame(height: 50)
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 25)
                                                .strokeBorder(Color.black, lineWidth: 2)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 25)
                                                        .fill(AppColors.boxColor)))
                            
                            Image("search")
                        }
                        
                        VStack( alignment: .leading, spacing: 10) {
                            Text( NSLocalizedString("idealFor", comment: ""))
                                .foregroundColor(.white)
                                .font(.custom("times", size: 26))
                            
                            Text( NSLocalizedString("chooseCategory", comment: ""))
                                .foregroundColor(.accentColor)
                                .font(.custom("Gilroy-Regular", size: 14))
                        }
                        
                    }.padding()
                    
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

                    if searchVM.loading {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else {
                        LazyVGrid( columns: columns, content: {
                            ForEach(searchVM.searchResults, id: \.id ) { result in
                                SingleSearchResult(user: result)
                                    .environmentObject(searchVM)
                            }
                        }).padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                    }
                }.padding(.top, 1)
                
            }.navigationBarTitle("")
            .navigationBarTitleView(SearchNavBar(title: "Community" ), displayMode: .inline)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
