//
//  SignleSearchResult.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.06.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SingleSearchResult: View {
    
    @EnvironmentObject var searchVM: SearchViewModel
    let user: SearchUserModel
    
    var body: some View {
        VStack( spacing: 5 ) {
            
            NavigationLink(
                destination: VisitedProfile(userID: user.id, userName: user.name),
                label: {
                    
                    VStack( spacing: 5 ) {
                        WebImage(url: URL(string: user.image))
                            .placeholder {
                                ProgressView()
                            }.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        Text( user.name )
                            .foregroundColor(.white)
                            .font(.custom("times", size: 16))
                        
                        HStack( spacing: 0 ) {
                            Text( NSLocalizedString("idealFor", comment: ""))
                                .foregroundColor(.gray)
                                .font(.custom("Gilroy-Regular", size: 12))
                            
                            Text( user.ideal)
                                .foregroundColor(.accentColor)
                                .font(.custom("Gilroy-Regular", size: 12))
                        }
                    }
                })
            
            SearchResultActionButtons(status: user.friendStatus, userID: user.id)
                .environmentObject(searchVM)
        }.padding()
        .background(AppColors.boxColor)
        .cornerRadius(12)
    }
}

struct SingleSearchResult_Previews: PreviewProvider {
    static var previews: some View {
        SingleSearchResult(user: SearchUserModel(id: 1, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal: "Business", friendStatus: 1))
            .environmentObject(SearchViewModel())
    }
}
