//
//  SearchResultActionButtons.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 30.06.21.
//

import SwiftUI

struct SearchResultActionButtons: View {
    
    @EnvironmentObject var searchVM: SearchViewModel
    @State private var helloSent: Bool = false
    let status: Int
    let userID: Int
    
    var body: some View {
        Group {
            switch status {
            case 1:     // user can send friend request
                Button(action: {
                    searchVM.connectUser(userID: userID)
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
            case 2:     // users are friends, no action needed
                Button(action: {
                    searchVM.sendGreetingMessage(userID: userID)
                    helloSent = true
                }, label: {
                    Text(helloSent ? "Greeting Sent" : "Say Hello")
                        .foregroundColor( .accentColor )
                        .font(.custom("Avenir", size: 14))
                        .padding(.vertical, 4)
                        .frame(width: 140)
                        .background(RoundedRectangle(cornerRadius: 4)
                                        .strokeBorder(AppColors.accentColor, lineWidth: 1)
                                        .background(AppColors.dataFilterGendersBg)
                    )
                })
            case 3:     // friend request is send, user can withdraw the request
                Button(action: {
                    searchVM.withdrawRequest(userID: userID)
                }, label: {
                    Text(NSLocalizedString("withdraw", comment: ""))
                        .foregroundColor( .accentColor )
                        .font(.custom("Avenir", size: 14))
                        .padding(.vertical, 4)
                        .frame(width: 140)
                        .background(RoundedRectangle(cornerRadius: 4)
                                        .strokeBorder(AppColors.accentColor, lineWidth: 1)
                                        .background(AppColors.dataFilterGendersBg)
                    )
                })
            case 4:     // user got friend request and is able to reject or accept
                VStack {
                    Button(action: {
                        searchVM.acceptFriendRequest(userID: userID)
                    }, label: {
                        Text(NSLocalizedString("accept", comment: ""))
                            .foregroundColor( .accentColor )
                            .font(.custom("Avenir", size: 14))
                            .padding(.vertical, 4)
                            .frame(width: 140)
                            .background(RoundedRectangle(cornerRadius: 4)
                                            .strokeBorder(AppColors.accentColor, lineWidth: 1)
                                            .background(AppColors.dataFilterGendersBg)
                        )
                    })
                    
                    Button(action: {
                        searchVM.rejectFriendRequest(userID: userID)
                    }, label: {
                        Text(NSLocalizedString("reject", comment: ""))
                            .foregroundColor( .accentColor )
                            .font(.custom("Avenir", size: 14))
                            .padding(.vertical, 4)
                            .frame(width: 140)
                            .background(RoundedRectangle(cornerRadius: 4)
                                            .strokeBorder(AppColors.accentColor, lineWidth: 1)
                                            .background(AppColors.dataFilterGendersBg)
                        )
                    })
                }
            default:
                EmptyView()
            }
        }
    }
}

struct SearchResultActionButtons_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultActionButtons(status: 4, userID: 4)
            .environmentObject(SearchViewModel())
    }
}
