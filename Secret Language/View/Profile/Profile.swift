//
//  Profile.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct Profile: View {
    
    @AppStorage( "storedContacts" ) private var contactsStored: Bool = false
    @ObservedObject var profileVM = ProfileViewModel()
    
    var body: some View {
        
        NavigationView  {
            
            ZStack {
                Background()
                
                if profileVM.loading {
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
                                    
                                    TextField(NSLocalizedString("search", comment: ""), text: $profileVM.searchText)
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
                                        Text( "\(profileVM.friendsCount)" )
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
                                                        Text( "\(profileVM.pendingCount)" )
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
                                                        Text( "\(profileVM.requestsCount)" )
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
                        }.padding()
                        .padding(.top, 30)
                    }
                }
                
                CustomAlert(isPresented: $profileVM.showAlert, alertMessage: profileVM.alertMessage, alignment: .center)
                    .offset(y: profileVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                    .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
                
            }.edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }.onAppear {
                profileVM.getCounts()
            }
        }.navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
