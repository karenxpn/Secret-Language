//
//  FriendRequestList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import SwiftUI

struct FriendRequestList: View {
    
    @ObservedObject var profileVM = ProfileViewModel()
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .none
        UITableView.appearance().backgroundColor = .none
        
        profileVM.getFriendRequestsWithPusher()
    }
    
    var body: some View {
        ZStack {
            Background()
            
            if profileVM.loading {
                ProgressView()
            } else {
                List {
                    ForEach(0..<profileVM.requestsList.count, id: \.self ) { index in
                        FriendRequestCell(request: profileVM.requestsList[index])
                            .environmentObject(profileVM)
                    }.onDelete(perform: { indexSet in
                        if let removeIndex = indexSet.first {
                            profileVM.rejectFriendRequest(userID: profileVM.requestsList[removeIndex].id)
                            profileVM.requestsList.remove(at: removeIndex)
                        }
                    }).listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }.padding(.top, 1)
            }
            
            CustomAlert(isPresented: $profileVM.showAlert, alertMessage: profileVM.alertMessage, alignment: .center)
                .offset(y: profileVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("")
        .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("myRequests", comment: "")), displayMode: .inline)
        .onAppear(perform: {
            profileVM.getFriendRequests()
        })
    }
}

struct FriendRequestList_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestList()
            .environmentObject(ProfileViewModel())
    }
}
