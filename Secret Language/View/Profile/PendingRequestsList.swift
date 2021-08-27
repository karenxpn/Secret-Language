//
//  PendingRequestsList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 23.06.21.
//

import SwiftUI

struct PendingRequestsList: View {
    
    @ObservedObject var profileVM = ProfileViewModel()
    
    var body: some View {
        ZStack {
            
            Background()
            
            if profileVM.loading && profileVM.pendingList.isEmpty {
                ProgressView()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(profileVM.pendingList, id: \.id ) { request in
                            PendingListCell(pendingRequest: request)
                                .environmentObject(profileVM)
                                .onAppear {
                                    if request.id == profileVM.pendingList[profileVM.pendingList.count-1].id {
                                        profileVM.page += 1
                                        profileVM.getPendingRequests()
                                    }
                                }
                        }
                        
                        if profileVM.loading {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                        
                    }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                }.padding(.top, 1)
            }
            
            CustomAlert(isPresented: $profileVM.showAlert, alertMessage: profileVM.alertMessage, alignment: .center)
                .offset(y: profileVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("")
        .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("myPendings", comment: "")), displayMode: .inline)
        .onAppear(perform: {
            profileVM.getPendingRequests()
        })
    }
}

struct PendingRequestsList_Previews: PreviewProvider {
    static var previews: some View {
        PendingRequestsList()
    }
}
