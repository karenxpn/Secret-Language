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
                
                
                    VStack( alignment: .leading, spacing: 20) {
                        Text( NSLocalizedString("letsFindFriends", comment: ""))
                            .foregroundColor(.white)
                            .font(.custom("times", size: 26))
                            .padding(.bottom)
                        
                        Text( NSLocalizedString("toStartSearch", comment: ""))
                            .foregroundColor(.accentColor)
                            .font(.custom("Gilroy-Regular", size: 14))
                        
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
                        
                        if friendsVM.loading {
                            ProgressView()
                        } else {
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
                                
                                NavigationLink( destination: Text("Pending"),
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
                        }
                        
                        ScrollView {
                            Text( "contacts here" )
                        }
                        
                    }.padding()
                    .padding(.top, 30)
                
                CustomAlert(isPresented: $friendsVM.showAlert, alertMessage: friendsVM.alertMessage, alignment: .center)
                    .offset(y: friendsVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                    .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
                
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Friends()
    }
}
