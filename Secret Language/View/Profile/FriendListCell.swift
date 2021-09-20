//
//  FriendRequestCell.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendListCell: View {
    
    @EnvironmentObject var profileVM: ProfileViewModel
    let friend: UserPreviewModel
    
    var body: some View {
        
        NavigationLink(destination: VisitedProfile(userID: friend.id, userName: friend.name)) {
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
                        
                        Text( friend.ideal)
                            .foregroundColor(AppColors.accentColor)
                            .font(.custom("Gilroy-Regular", size: 15))
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    profileVM.sendGreetingMessage(userID: friend.id)
                }, label: {
                    Text("👋🏻")
                        .font(.title)
                })
            }.padding()
        }
    }
}

struct FriendListtCell_Previews: PreviewProvider {
    static var previews: some View {
        FriendListCell( friend: UserPreviewModel(id: 1, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal: "Business"))
            .environmentObject(ProfileViewModel())
    }
}
