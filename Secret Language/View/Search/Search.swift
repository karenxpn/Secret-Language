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
                    VStack {
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
                    }.padding()
                }.padding(.top, 1)
            }.navigationBarTitle("")
            .navigationBarTitleView(SearchNavBar(title: "Community" ), displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
