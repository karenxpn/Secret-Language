//
//  FriendRequestList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import SwiftUI

struct FriendRequestList: View {
    
    @EnvironmentObject var friendsVM: FriendsViewModel
    
    init() {
       UITableView.appearance().separatorStyle = .none
       UITableViewCell.appearance().backgroundColor = .none
       UITableView.appearance().backgroundColor = .none
    }
    
    var body: some View {
        ZStack {
            Background()
            
            List {
                ForEach(0..<friendsVM.requestsList.count, id: \.self ) { index in
                    FriendRequestCell(request: friendsVM.requestsList[index])
                        .environmentObject(friendsVM)
                }.onDelete(perform: { indexSet in
                    
                }).listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }.padding(.top, 1)
        }.navigationBarTitle("")
        .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("myRequests", comment: "")), displayMode: .inline)
        .onAppear(perform: {
            // get friend requests
        })
    }
}

struct FriendRequestList_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestList()
            .environmentObject(FriendsViewModel())
    }
}
