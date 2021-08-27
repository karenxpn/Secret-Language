//
//  FriendsList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import SwiftUI

struct FriendsList: View {
    
    @ObservedObject var profileVM = ProfileViewModel()
    
    var body: some View {
        ZStack {
            Background()
            
            if profileVM.loading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(profileVM.friendsList, id: \.id ) { friend in
                            FriendListCell(friend: friend)
                                .environmentObject(profileVM)
                                .onAppear {
                                    if friend.id == profileVM.friendsList[profileVM.friendsList.count-1].id {
                                        profileVM.page += 1
                                        profileVM.getFriends()
                                    }
                                }
                        }
                    }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                }.padding(.top, 1)
            }
            
            CustomAlert(isPresented: $profileVM.showAlert, alertMessage: profileVM.alertMessage, alignment: .center)
                .offset(y: profileVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle(Text( "" ), displayMode: .inline)
        .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("myFriends", comment: "")), displayMode: .inline)
        .onAppear(perform: {
            profileVM.getFriends()
        })
    }
}

struct FriendsList_Previews: PreviewProvider {
    static var previews: some View {
        FriendsList()
            .environmentObject(ProfileViewModel())
    }
}
