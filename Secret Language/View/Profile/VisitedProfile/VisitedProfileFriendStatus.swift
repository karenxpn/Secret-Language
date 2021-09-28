//
//  VIsitedProfileFriendStatus.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.09.21.
//

import SwiftUI

struct VisitedProfileFriendStatus: View {
    
    @EnvironmentObject var profileVM: VisitedProfileViewModel
    let status: Int
    let userID: Int
    
    var body: some View {
        Group {
            switch status {
            case 1:     // user can send friend request
                Button(action: {
                    profileVM.connectUser(userID: userID)
                }, label: {
                    Text(NSLocalizedString("connect", comment: ""))
                        .foregroundColor(AppColors.accentColor)
                        .font(.custom("Avenir", size: 18))
                        .frame(width: .greedy, height: 50)
                        .background(RoundedRectangle(cornerRadius: 25)
                                        .strokeBorder(AppColors.accentColor, lineWidth: 2)
                                        .background(RoundedRectangle(cornerRadius: 25)
                                                        .fill(AppColors.dataFilterGendersBg))
                        ).padding(.horizontal)
                })
            case 2:     // users are friends, no action needed
                
//                Button(action: {
//
//                }, label: {
//                    Text(NSLocalizedString("sendMessage", comment: ""))
//                        .foregroundColor(AppColors.accentColor)
//                        .font(.custom("Avenir", size: 18))
//                        .frame(width: .greedy, height: 50)
//                        .background(RoundedRectangle(cornerRadius: 25)
//                                        .strokeBorder(AppColors.accentColor, lineWidth: 2)
//                                        .background(RoundedRectangle(cornerRadius: 25)
//                                                        .fill(AppColors.dataFilterGendersBg))
//                        ).padding(.horizontal)
//                })
                EmptyView()
            case 3:     // friend request is send, user can withdraw the request
                Button(action: {
                    profileVM.withdrawRequest(userID: userID)
                }, label: {
                    Text(NSLocalizedString("withdraw", comment: ""))
                        .foregroundColor(AppColors.accentColor)
                        .font(.custom("Avenir", size: 18))
                        .frame(width: .greedy, height: 50)
                        .background(RoundedRectangle(cornerRadius: 25)
                                        .strokeBorder(AppColors.accentColor, lineWidth: 2)
                                        .background(RoundedRectangle(cornerRadius: 25)
                                                        .fill(AppColors.dataFilterGendersBg))
                        ).padding(.horizontal)
                })
            case 4:     // user got friend request and is able to reject or accept
                HStack( spacing: 15 ) {
                    Button(action: {
                        profileVM.acceptFriendRequest(userID: userID)
                    }, label: {
                        Text(NSLocalizedString("accept", comment: ""))
                            .foregroundColor( Color.black )
                            .font(.custom("Avenir", size: 18))
                            .frame(width: .greedy, height: 50)
                            .background(RoundedRectangle(cornerRadius: 25)
                                            .fill(AppColors.accentColor)
                            ).padding(.horizontal)
                    })
                    
                    Button(action: {
                        profileVM.rejectFriendRequest(userID: userID)
                    }, label: {
                        Text(NSLocalizedString("reject", comment: ""))
                            .foregroundColor( Color.red )
                            .font(.custom("Avenir", size: 18))
                            .frame(width: .greedy, height: 50)
                            .background(RoundedRectangle(cornerRadius: 25)
                                            .strokeBorder(Color.red, lineWidth: 2)
                            ).padding(.horizontal)
                    })
                }
            default:
                EmptyView()
            }
        }
    }
}

//struct VisitedProfileFriendStatus_Previews: PreviewProvider {
//    static var previews: some View {
//        VIsitedProfileFriendStatus(profile: .constant(PreviewParameters.match))
//    }
//}
