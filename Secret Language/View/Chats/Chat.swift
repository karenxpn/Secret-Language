//
//  Chat.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct Chat: View {
    @AppStorage( "shouldSubscribe" ) private var shouldSubscribe: Bool = true
    @ObservedObject var chatVM = ChatViewModel()
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .none
        UITableView.appearance().backgroundColor = .none
        
        chatVM.getChatsWithPusher()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                
                if chatVM.loading && chatVM.chats.isEmpty {
                    ProgressView()
                } else {
                    if shouldSubscribe {
                        MonthlySubscriptionView()
                    } else {
                        ChatList()
                            .environmentObject(chatVM)
                    }
                }

                CustomAlert(isPresented: $chatVM.showAlert, alertMessage: chatVM.alertMessage, alignment: .center)
                    .offset(y: chatVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                    .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
                
            }.navigationBarTitle("")
            .navigationBarTitleView(SearchNavBar(title: NSLocalizedString("messaging", comment: "")), displayMode: .inline)
            .onAppear {
                chatVM.getChats()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "reloadChats"))) { _ in
            chatVM.getChats()
        }
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chat()
    }
}
