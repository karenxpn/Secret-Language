//
//  FriendsList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import SwiftUI

struct FriendsList: View {
    
    @ObservedObject var friendsVM = FriendsViewModel()
    
    var body: some View {
        ZStack {
            Background()
            
            if friendsVM.loading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(friendsVM.friendsList, id: \.id ) { friend in
                            FriendListCell(friend: friend)
                                .environmentObject(friendsVM)
                        }
                    }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                }.padding(.top, 1)
            }
            
            CustomAlert(isPresented: $friendsVM.showAlert, alertMessage: friendsVM.alertMessage, alignment: .center)
                .offset(y: friendsVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.navigationBarTitle("")
        .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("myFriends", comment: "")), displayMode: .inline)
        .onAppear(perform: {
            friendsVM.getFriends()
        })
    }
}

struct FriendsList_Previews: PreviewProvider {
    static var previews: some View {
        FriendsList()
            .environmentObject(FriendsViewModel())
    }
}
