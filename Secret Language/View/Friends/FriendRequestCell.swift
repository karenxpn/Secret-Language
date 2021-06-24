//
//  FriendRequestCell.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendRequestCell: View {
    
    @EnvironmentObject var friendsVM: FriendsViewModel
    let request: UserPreviewModel
    var body: some View {
        
        Button {
            
        } label: {
            HStack( spacing: 20) {
                WebImage(url: URL(string: request.image))
                    .placeholder {
                        ProgressView()
                    }.resizable()
                    .scaledToFill()
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                
                VStack( alignment: .leading) {
                    Text( request.name )
                        .foregroundColor(.white)
                        .font(.custom("times", size: 18))
                    
                    HStack( spacing: 0) {
                        Text( "\(NSLocalizedString("idealFor", comment: ""))")
                            .foregroundColor(.gray)
                            .font(.custom("Gilroy-Regular", size: 15))
                        
                        Text( request.ideal)
                            .foregroundColor(.accentColor)
                            .font(.custom("Gilroy-Regular", size: 15))
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    friendsVM.acceptFriendRequest(userID: request.id)
                }, label: {
                    Text(NSLocalizedString("accept", comment: ""))
                        .foregroundColor( .accentColor )
                        .font(.custom("Gilroy-Regular", size: 14))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 18)
                        .background(RoundedRectangle(cornerRadius: 4)
                                        .strokeBorder(AppColors.accentColor, lineWidth: 1.5)
                                        .background(AppColors.dataFilterGendersBg)
                    )
                })
            }.padding()
        }
    }
}

struct FriendRequestCell_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestCell( request: UserPreviewModel(id: 1, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal: "Business"))
            .environmentObject(FriendsViewModel())
    }
}
