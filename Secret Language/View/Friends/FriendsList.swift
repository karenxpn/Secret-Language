//
//  FriendsList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import SwiftUI

struct FriendsList: View {
    
    @EnvironmentObject var friendsVM: FriendsViewModel
    
    var body: some View {
        ZStack {
            Background()
            
            ScrollView {
                LazyVStack {
                    ForEach(friendsVM.friendsList, id: \.id ) { friend in
                        FriendListCell(friend: friend)
                            .environmentObject(friendsVM)
                    }
                }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
            }.padding(.top, 1)
        }.navigationBarTitle("")
        .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("myFriends", comment: "")), displayMode: .inline)
        .onAppear(perform: {
            // get friend requests
        })
    }
}

struct FriendsList_Previews: PreviewProvider {
    static var previews: some View {
        FriendsList()
            .environmentObject(FriendsViewModel())
    }
}
