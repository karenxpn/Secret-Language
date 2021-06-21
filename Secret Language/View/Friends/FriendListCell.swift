//
//  FriendRequestCell.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendListCell: View {
    
    @EnvironmentObject var friendsVM: FriendsViewModel
    let friend: UserPreviewModel
    
    var body: some View {
        
        HStack( spacing: 20) {
            WebImage(url: URL(string: friend.image))
                .placeholder {
                    ProgressView()
                }.resizable()
                .scaledToFill()
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            
            VStack( alignment: .leading) {
                Text( friend.name )
                    .foregroundColor(.white)
                    .font(.custom("times", size: 18))
                
                HStack( spacing: 0) {
                    Text( "\(NSLocalizedString("idealFor", comment: ""))")
                        .foregroundColor(.gray)
                        .font(.custom("Gilroy-Regular", size: 15))
                    
                    Text( friend.ideal_for)
                        .foregroundColor(.accentColor)
                        .font(.custom("Gilroy-Regular", size: 15))
                }
            }
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Text("👋🏻")
                    .font(.title)
//                    .foregroundColor( .accentColor )
//                    .font(.custom("Gilroy-Regular", size: 14))
//                    .padding(.vertical, 8)
//                    .padding(.horizontal, 18)
//                    .background(RoundedRectangle(cornerRadius: 4)
//                                    .strokeBorder(AppColors.accentColor, lineWidth: 1.5)
//                                    .background(AppColors.dataFilterGendersBg)
//                )
            })
        }.padding()
    }
}

struct FriendListtCell_Previews: PreviewProvider {
    static var previews: some View {
        FriendListCell( friend: UserPreviewModel(id: 1, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business"))
            .environmentObject(FriendsViewModel())
    }
}
