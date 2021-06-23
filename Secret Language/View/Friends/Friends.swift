//
//  Profile.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct Friends: View {
    
    @ObservedObject var friendsVM = FriendsViewModel()
    
    var body: some View {
        
        NavigationView  {
            
            ZStack {
                Background()
                
                if friendsVM.loading {
                    ProgressView()
                } else {
                    
                    ScrollView( showsIndicators: false ) {
                        VStack( alignment: .leading, spacing: 20) {
                            Text( NSLocalizedString("letsFindFriends", comment: ""))
                                .foregroundColor(.white)
                                .font(.custom("times", size: 26))
                                .padding(.bottom)
                            
                            Text( NSLocalizedString("toStartSearch", comment: ""))
                                .foregroundColor(.accentColor)
                                .font(.custom("Gilroy-Regular", size: 14))
                            
                            HStack {
                                Spacer()
                                
                                HStack {
                                    
                                    Image("searchIcon")
                                    
                                    TextField(NSLocalizedString("search", comment: ""), text: $friendsVM.searchText)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                        .frame(height: 50)
                                        .listRowBackground(Color.clear)
                                        .listRowInsets(EdgeInsets())
                                    
                                }.padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 25).fill(AppColors.boxColor))
                                .frame(width: UIScreen.main.bounds.size.width * 0.9)
                                
                                Spacer()
                            }
                            
                            HStack {
                                
                                Spacer()
                                
                                NavigationLink( destination: FriendsList(), label: {
                                    VStack {
                                        Text( "\(friendsVM.friendsCount)" )
                                            .foregroundColor(.white)
                                            .font(.custom("Avenir", size: 20))
                                            .fontWeight(.bold)
                                        
                                        Text( NSLocalizedString("friends", comment: ""))
                                            .foregroundColor(.white)
                                            .font(.custom("Gilroy-Regular", size: 14))
                                    }
                                })
                                
                                Spacer()
                                
                                NavigationLink( destination: PendingRequestsList(),
                                                label: {
                                                    VStack {
                                                        Text( "\(friendsVM.pendingCount)" )
                                                            .foregroundColor(.white)
                                                            .font(.custom("Avenir", size: 20))
                                                            .fontWeight(.bold)
                                                        
                                                        Text( NSLocalizedString("pending", comment: ""))
                                                            .foregroundColor(.white)
                                                            .font(.custom("Gilroy-Regular", size: 14))
                                                    }
                                                })
                                
                                Spacer()
                                
                                NavigationLink( destination: FriendRequestList(),
                                                label: {
                                                    VStack {
                                                        Text( "\(friendsVM.requestsCount)" )
                                                            .foregroundColor(.white)
                                                            .font(.custom("Avenir", size: 20))
                                                            .fontWeight(.bold)
                                                        
                                                        Text( NSLocalizedString("requests", comment: ""))
                                                            .foregroundColor(.white)
                                                            .font(.custom("Gilroy-Regular", size: 14))
                                                    }
                                                })
                                Spacer()
                            }
                            
                            LazyVStack {
                                ForEach( friendsVM.contacts, id: \.id ) { contact in
                                    ContactListCell(contact: contact)
                                        .environmentObject(friendsVM)
                                }
                            }.padding(.bottom, UIScreen.main.bounds.size.height * 0.1)
                            
                        }.padding()
                        .padding(.top, 30)
                    }
                    
                }
                
                CustomAlert(isPresented: $friendsVM.showAlert, alertMessage: friendsVM.alertMessage, alignment: .center)
                    .offset(y: friendsVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                    .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
                
            }.edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }.onAppear {
                friendsVM.getCounts()
                friendsVM.permissions()
            }
        }.navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Friends()
    }
}
