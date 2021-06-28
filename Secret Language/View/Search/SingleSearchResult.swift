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
    let user: UserPreviewModel
    
    var body: some View {
        VStack( spacing: 5) {
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
                    .font(.custom("Gilroy-Regular", size: 14))
                
                Text( user.ideal)
                    .foregroundColor(.accentColor)
                    .font(.custom("Gilroy-Regular", size: 14))
            }
            
            Button(action: {
                searchVM.connectUser(userID: user.id)
            }, label: {
                Text(NSLocalizedString("connect", comment: ""))
                    .foregroundColor( .accentColor )
                    .font(.custom("Avenir", size: 14))
                    .padding(.vertical, 4)
                    .frame(width: 140)
                    .background(RoundedRectangle(cornerRadius: 4)
                                    .strokeBorder(AppColors.accentColor, lineWidth: 1)
                                    .background(AppColors.dataFilterGendersBg)
                )
            })
        }.padding()
        .background(AppColors.boxColor)
        .cornerRadius(12)
    }
}

struct SingleSearchResult_Previews: PreviewProvider {
    static var previews: some View {
        SingleSearchResult(user: UserPreviewModel(id: 1, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal: "Business"))
            .environmentObject(SearchViewModel())
    }
}
