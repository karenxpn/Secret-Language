//
//  PendingRequestsList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 23.06.21.
//

import SwiftUI

struct PendingRequestsList: View {
    
    @ObservedObject var friendsVM = FriendsViewModel()
    
    var body: some View {
        ZStack {
            
            Background()
            
            if friendsVM.loading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(friendsVM.pendingList, id: \.id ) { request in
                            PendingListCell(pendingRequest: request)
                                .environmentObject(friendsVM)
                        }
                    }
                }
            }
            
        }.edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("")
        .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("myPendings", comment: "")), displayMode: .inline)
        .onAppear(perform: {
            friendsVM.getPendingRequests()
        })
    }
}

struct PendingRequestsList_Previews: PreviewProvider {
    static var previews: some View {
        PendingRequestsList()
    }
}
