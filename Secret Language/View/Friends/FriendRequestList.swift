//
//  FriendRequestList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import SwiftUI

struct FriendRequestList: View {
    
    @ObservedObject var friendsVM = FriendsViewModel()
    
    init() {
       UITableView.appearance().separatorStyle = .none
       UITableViewCell.appearance().backgroundColor = .none
       UITableView.appearance().backgroundColor = .none
    }
    
    var body: some View {
        ZStack {
            Background()
            
            if friendsVM.loading {
                ProgressView()
            } else {
                List {
                    ForEach(0..<friendsVM.requestsList.count, id: \.self ) { index in
                        FriendRequestCell(request: friendsVM.requestsList[index])
                            .environmentObject(friendsVM)
                    }.onDelete(perform: { indexSet in
                        
                    }).listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }.padding(.top, 1)
            }
            
            CustomAlert(isPresented: $friendsVM.showAlert, alertMessage: friendsVM.alertMessage, alignment: .center)
                .offset(y: friendsVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.navigationBarTitle("")
        .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("myRequests", comment: "")), displayMode: .inline)
        .onAppear(perform: {
            friendsVM.getFriendRequests()
        })
    }
}

struct FriendRequestList_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestList()
            .environmentObject(FriendsViewModel())
    }
}
