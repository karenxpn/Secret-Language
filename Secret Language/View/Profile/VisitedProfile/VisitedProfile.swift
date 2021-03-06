//
//  VisitedProfile.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.06.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct VisitedProfile: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var profileVM = VisitedProfileViewModel()
    @State private var actionSheet: Bool = false
    
    let userID: Int
    let userName: String
    
    var body: some View {
        ZStack {
            Background()
            
            if profileVM.loading {
                ProgressView()
            } else if profileVM.visitedProfile != nil {
                ScrollView( showsIndicators: false ) {
                    
                    ZStack( alignment: .bottomTrailing ) {
                        
                        TapImagesCarousel(images: profileVM.visitedProfile!.images.map{ $0.image }, x: .constant( 0 ))
                        
                        if !profileVM.visitedProfile!.instagram.isEmpty {
                            Button(action: {
                                profileVM.openInstagram(username: profileVM.visitedProfile!.instagram)
                            }, label: {
                                Image( "instagram" )
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame( width: 35, height: 35 )
                                    .padding()
                                    .offset( y: -10)
                            })
                        }
                    }
                    
                    if profileVM.visitedProfile!.friendStatus != 3 {
                        VisitedProfileFriendStatus(status: profileVM.visitedProfile!.friendStatus, userID: profileVM.visitedProfile!.id)
                            .environmentObject(profileVM)
                    }
                    
                    VStack {
                        Text( "\(profileVM.visitedProfile!.name), \(profileVM.visitedProfile!.age)" )
                            .foregroundColor(.white)
                            .font(.custom("times", size: 20))
                        
                        HStack( spacing: 0) {
                            Text( NSLocalizedString("idealFor", comment: ""))
                                .foregroundColor(.gray)
                                .font(.custom("avenir", size: 14))
                            
                            Text(profileVM.visitedProfile!.ideal_for)
                                .foregroundColor(AppColors.accentColor)
                                .font(.custom("avenir", size: 14))
                        }
                        
                        Text( profileVM.visitedProfile!.distance )
                            .font(.custom("times", size: 14))
                            .foregroundColor(.white)
                        
                        Text( profileVM.visitedProfile!.looking_for)
                            .foregroundColor(AppColors.accentColor)
                            .font(.custom("avenir", size: 14))
                    }
                    
                    Text( "..." )
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(.bottom, 8)
                    
                    HStack {
                        VStack( alignment: .leading) {
                            Text( profileVM.visitedProfile!.my_birthday )
                                .font(.custom("times", size: 16))
                                .foregroundColor(.white)
                            
                            HStack( spacing: 0) {
                                Text( NSLocalizedString("weekOf", comment: ""))
                                    .foregroundColor(.gray)
                                    .font(.custom("Avenir", size: 12))
                                
                                Text( profileVM.visitedProfile!.my_birthday_name )
                                    .foregroundColor(AppColors.accentColor)
                                    .font(.custom("Avenir", size: 12))
                            }
                        }
                        
                        Spacer()
                        
                        VStack( alignment: .trailing) {
                            Text( profileVM.visitedProfile!.user_birthday )
                                .font(.custom("times", size: 16))
                                .foregroundColor(.white)
                            
                            HStack( spacing: 0) {
                                Text( NSLocalizedString("weekOf", comment: ""))
                                    .foregroundColor(.gray)
                                    .font(.custom("Avenir", size: 12))
                                
                                Text( profileVM.visitedProfile!.user_birthday_name )
                                    .foregroundColor(AppColors.accentColor)
                                    .font(.custom("Avenir", size: 12))
                            }
                        }
                    }.padding(.horizontal)
                    
                    ImageHelper(image: profileVM.visitedProfile!.rel_image, contentMode: .fit, progressViewTintColor: .black)
                        .frame(width: 130, height: 130)
                        .padding()
                        .background(.white)
                        .clipShape(Circle())
                    
                    VStack {
                        Text( profileVM.visitedProfile!.sln )
                            .foregroundColor(.white)
                            .font(.custom("times", size: 24))
                            .fontWeight(.bold)
                            .padding(8)
                        
                        Text( profileVM.visitedProfile!.sln_description)
                            .foregroundColor(AppColors.accentColor)
                            .font(.custom("times-italic", size: 18))
                            .multilineTextAlignment(.center)
                            .padding(8)
                        
                        Text( "\(NSLocalizedString("since1701", comment: "")) \(profileVM.visitedProfile!.famous_years)")
                            .foregroundColor(.white)
                            .font(.custom("times", size: 16))
                            .multilineTextAlignment(.center)
                            .padding(8)
                        
                        Text( NSLocalizedString("relationshipPersonality", comment: ""))
                            .font(.custom("times", size: 18))
                            .foregroundColor(AppColors.accentColor)
                        
                        Text( profileVM.visitedProfile!.report )
                            .foregroundColor(.white)
                            .font(.custom("times", size: 16))
                            .padding(.horizontal, 10)
                        
                        Text( NSLocalizedString("advice", comment: ""))
                            .font(.custom("times", size: 18))
                            .foregroundColor(AppColors.accentColor)
                        
                        Text( profileVM.visitedProfile!.advice )
                            .foregroundColor(.white)
                            .font(.custom("times", size: 16))
                            .multilineTextAlignment(.center)
                            .padding(8)
                        
                        if profileVM.visitedProfile!.friendStatus == 3 {
                            VisitedProfileFriendStatus(status: profileVM.visitedProfile!.friendStatus, userID: profileVM.visitedProfile!.id)
                                .environmentObject(profileVM)
                        }
                        
                        Text("\(profileVM.visitedProfile!.signUpDate)")
                            .foregroundColor(.white)
                            .font(.custom("avenir", size: 14))
                            .padding()
                    }.fixedSize(horizontal: false, vertical: true)
                                        
                    AllRightsReservedMadeByDoejo()
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                    
                }.padding(.top, 1)
            }
            
            CustomAlert(isPresented: $profileVM.showAlert, alertMessage: profileVM.alertMessage, alignment: .center)
                .offset(y: profileVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.navigationBarTitle("")
            .navigationBarTitleView(SearchNavBar(title: userName))
            .navigationBarItems(trailing: HStack( spacing: 10 ) {
                
                Button(action: {
                    profileVM.shareProfile(userID: userID)
                }, label: {
                    Image( "shareIcon" )
                        .frame( width: 40, height: 40)
                })
                
                Button(action: {
                    actionSheet.toggle()
                }, label: {
                    Image("moreIcon")
                        .frame( width: 35, height: 35)
                })
            })
            .onAppear {
                profileVM.getVisitedProfile(userID: userID)
            }.actionSheet(isPresented: $actionSheet) {
                ActionSheet(title: Text( NSLocalizedString("action", comment: "")), message: nil,
                            buttons: profileVM.visitedProfile?.friendStatus == 2 ?
                            [ .default(Text( NSLocalizedString("reportUser", comment: ""))
                                        .foregroundColor(.white), action: {
                    profileVM.reportVisitedProfile(userID: userID)
                }),
                              .default(Text( NSLocalizedString("flag", comment: ""))
                                        .foregroundColor(.white), action: {
                    profileVM.flagVisitedProfile(userID: userID)
                }),
                              .destructive(Text( NSLocalizedString("blockUser", comment: ""))
                                            .foregroundColor(.white), action: {
                    profileVM.blockVisitedProfile(userID: userID)
                }),
                              .destructive(Text( NSLocalizedString("deleteFriend", comment: ""))
                                            .foregroundColor(.white), action: {
                    profileVM.askDelete()
                }),
                              .cancel()]  :
                                [ .default(Text( NSLocalizedString("reportUser", comment: ""))
                                            .foregroundColor(.white), action: {
                    profileVM.reportVisitedProfile(userID: userID)
                }),
                                  .default(Text( NSLocalizedString("flag", comment: ""))
                                            .foregroundColor(.white), action: {
                    profileVM.flagVisitedProfile(userID: userID)
                }),
                                  .destructive(Text( NSLocalizedString("blockUser", comment: ""))
                                                .foregroundColor(.white), action: {
                    profileVM.blockVisitedProfile(userID: userID)
                }),
                                  .cancel()])
            }.alert(isPresented: $profileVM.reportedOrBlockedAlert) {
                
                if profileVM.alertType == .report {
                    return Alert(title: Text( "Done" ), message: Text(profileVM.reportedOrBlockedAlertMessage), dismissButton: .default(Text( "OK" ), action: {
                        presentationMode.wrappedValue.dismiss()
                    }))
                } else {
                    return Alert(title: Text( "Delete Friend" ), message: Text(profileVM.reportedOrBlockedAlertMessage), primaryButton: .default(Text( "OK" )), secondaryButton: .destructive(Text( "Delete" ), action: {
                        profileVM.deleteFriend(userID: userID)
                    }))
                }
            }
    }
}

struct VisitedProfile_Previews: PreviewProvider {
    static var previews: some View {
        VisitedProfile(userID: 1, userName: "John Smith")
    }
}
