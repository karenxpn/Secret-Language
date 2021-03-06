//
//  Profile.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI
import SDWebImageSwiftUI
import FBSDKCoreKit

struct Profile: View {
    
    @ObservedObject var profileVM = ProfileViewModel()
    @StateObject var shareReportVM = SharedReportViewModel()
    @State private var navigateToGallery: Bool = false
    @State private var navigateToSettings: Bool = false
    
    var body: some View {
        
        NavigationView  {
            
            if #available(iOS 15.0, *) {
                ZStack {
                    Background()
                    
                    if profileVM.loading {
                        ProgressView()
                    } else if profileVM.profile != nil {
                        
                        ScrollView( showsIndicators: false ) {
                            
                            VStack( spacing: 20) {
                                
                                Button {
                                    navigateToGallery.toggle()
                                } label: {
                                    ZStack( alignment: .bottomTrailing) {
                                        WebImage(url: URL(string: profileVM.profile!.image))
                                            .placeholder(content: {
                                                ProgressView()
                                            })
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 110, height: 110)
                                            .clipShape(Circle())
                                        
                                        Image("camera")
                                    }
                                }.background(
                                    NavigationLink(destination: ProfileImageGallery(isPresented: $navigateToGallery),
                                                   isActive: $navigateToGallery) {
                                                       EmptyView()
                                                   }.hidden()
                                )
                                
                                
                                
                                Text( "\(profileVM.profile!.name), \(profileVM.profile!.age)")
                                    .foregroundColor(.white)
                                    .font(.custom("AppleMyungjo", size: 20))
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    NavigationLink( destination: FriendsList(), label: {
                                        VStack {
                                            Text( "\(profileVM.profile!.friends)" )
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
                                            Text( "\(profileVM.profile!.pending)" )
                                                .foregroundColor(.white)
                                                .font(.custom("Avenir", size: 20))
                                                .fontWeight(.bold)
                                            
                                            Text( NSLocalizedString("pending", comment: ""))
                                                .foregroundColor(.white)
                                                .font(.custom("Gilroy-Regular", size: 14))
                                        }
                                    })
                                    
                                    Spacer()
                                    
                                    NavigationLink( destination: FriendRequestList(), label: {
                                        VStack {
                                            Text( "\(profileVM.profile!.requests)" )
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
                                .padding(.top, 20)
                            
                            BirthdayReportInnerView(report: profileVM.profile!.birthday_report)
                                .environmentObject(shareReportVM)
                            
                        }.padding(.top, 1)
                    }
                    
                    CustomAlert(isPresented: $profileVM.showAlert, alertMessage: profileVM.alertMessage, alignment: .center)
                        .offset(y: profileVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                        .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
                    
                }.edgesIgnoringSafeArea(.bottom)
                    .navigationBarTitle("")
                    .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("profile", comment: "")), displayMode: .inline)
                    .navigationBarItems(trailing:  HStack {
                        
                        Button(action: {
                            profileVM.shareProfile(userID: profileVM.profile!.id)
                        }, label: {
                            Image( "shareIcon" )
                                .frame( width: 40, height: 40)
                        }).disabled( profileVM.profile?.id == nil)
                        
                        
                        Button {
                            navigateToSettings.toggle()
                        } label: {
                            Image("settings")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding([.leading, .top, .bottom])
                        }.background(
                            NavigationLink( destination: SettingsView(), isActive: $navigateToSettings, label: {
                                EmptyView()
                            }).hidden()
                        )
                    }).onTapGesture {
                        UIApplication.shared.endEditing()
                    }.task {
                        profileVM.getProfile()
                        profileVM.getProfileWithPusher()
                    }
            } else {
                ZStack {
                    Background()
                    
                    if profileVM.loading {
                        ProgressView()
                    } else if profileVM.profile != nil {
                        
                        ScrollView( showsIndicators: false ) {
                            
                            VStack( spacing: 20) {
                                
                                Button {
                                    navigateToGallery.toggle()
                                } label: {
                                    ZStack( alignment: .bottomTrailing) {
                                        WebImage(url: URL(string: profileVM.profile!.image))
                                            .placeholder(content: {
                                                ProgressView()
                                            })
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 110, height: 110)
                                            .clipShape(Circle())
                                        
                                        Image("camera")
                                    }
                                }.background(
                                    NavigationLink(destination: ProfileImageGallery(isPresented: $navigateToGallery),
                                                   isActive: $navigateToGallery) {
                                                       EmptyView()
                                                   }.hidden()
                                )
                                
                                
                                
                                Text( "\(profileVM.profile!.name), \(profileVM.profile!.age)")
                                    .foregroundColor(.white)
                                    .font(.custom("AppleMyungjo", size: 20))
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    NavigationLink( destination: FriendsList(), label: {
                                        VStack {
                                            Text( "\(profileVM.profile!.friends)" )
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
                                            Text( "\(profileVM.profile!.pending)" )
                                                .foregroundColor(.white)
                                                .font(.custom("Avenir", size: 20))
                                                .fontWeight(.bold)
                                            
                                            Text( NSLocalizedString("pending", comment: ""))
                                                .foregroundColor(.white)
                                                .font(.custom("Gilroy-Regular", size: 14))
                                        }
                                    })
                                    
                                    Spacer()
                                    
                                    NavigationLink( destination: FriendRequestList(), label: {
                                        VStack {
                                            Text( "\(profileVM.profile!.requests)" )
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
                                .padding(.top, 20)
                            
                            BirthdayReportInnerView(report: profileVM.profile!.birthday_report)
                                .environmentObject(shareReportVM)
                            
                        }.padding(.top, 1)
                    }
                    
                    CustomAlert(isPresented: $profileVM.showAlert, alertMessage: profileVM.alertMessage, alignment: .center)
                        .offset(y: profileVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                        .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
                    
                }.edgesIgnoringSafeArea(.bottom)
                    .navigationBarTitle("")
                    .navigationBarTitleView(FriendsNavBar(title: NSLocalizedString("profile", comment: "")), displayMode: .inline)
                    .navigationBarItems(trailing:  HStack {
                        
                        Button(action: {
                            profileVM.shareProfile(userID: profileVM.profile!.id)
                        }, label: {
                            Image( "shareIcon" )
                                .frame( width: 40, height: 40)
                        }).disabled( profileVM.profile?.id == nil)
                        
                        
                        Button {
                            navigateToSettings.toggle()
                        } label: {
                            Image("settings")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding([.leading, .top, .bottom])
                        }.background(
                            NavigationLink( destination: SettingsView(), isActive: $navigateToSettings, label: {
                                EmptyView()
                            }).hidden()
                        )
                    }).onTapGesture {
                        UIApplication.shared.endEditing()
                    }.onAppear {
                        profileVM.getProfile()
                        profileVM.getProfileWithPusher()
                    }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
