//
//  VisitedProfile.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.06.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct VisitedProfile: View {
    
    @ObservedObject var profileVM = ProfileViewModel()
    let userID: Int
    let userName: String
    
    var body: some View {
        ZStack {
            Background()
            
            if profileVM.loading {
                ProgressView()
            } else if profileVM.visitedProfile != nil {
                ScrollView( showsIndicators: false ) {
                    
                    WebImage(url: URL(string: profileVM.visitedProfile!.image))
                        .placeholder(content: {
                            ProgressView()
                        })
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.size.width - 24,
                               height: UIScreen.main.bounds.size.height * 0.7)
                        .clipped()
                        .cornerRadius(15)
                        .padding(.vertical)
                    
                    Text( "\(profileVM.visitedProfile!.name), \(profileVM.visitedProfile!.age)" )
                        .foregroundColor(.white)
                        .font(.custom("times", size: 20))
                    
                    HStack( spacing: 0) {
                        Text( NSLocalizedString("idealFor", comment: ""))
                            .foregroundColor(.gray)
                            .font(.custom("avenir", size: 14))
                        
                        Text(profileVM.visitedProfile!.ideal)
                            .foregroundColor(.accentColor)
                            .font(.custom("avenir", size: 14))
                    }
                    
                    Text( "..." )
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(.bottom, 8)
                    
                    HStack {
                        VStack( alignment: .leading) {
                            Text( profileVM.visitedProfile!.myBirthday )
                                .font(.custom("times", size: 16))
                                .foregroundColor(.white)
                            
                            HStack( spacing: 0) {
                                Text( NSLocalizedString("weekOf", comment: ""))
                                    .foregroundColor(.gray)
                                    .font(.custom("Avenir", size: 12))
                                
                                Text( profileVM.visitedProfile!.myBirthdayWeek )
                                    .foregroundColor(.accentColor)
                                    .font(.custom("Avenir", size: 12))
                            }
                        }
                        
                        Spacer()
                        
                        VStack( alignment: .trailing) {
                            Text( profileVM.visitedProfile!.partnerBirthday )
                                .font(.custom("times", size: 16))
                                .foregroundColor(.white)
                            
                            HStack( spacing: 0) {
                                Text( NSLocalizedString("weekOf", comment: ""))
                                    .foregroundColor(.gray)
                                    .font(.custom("Avenir", size: 12))
                                
                                Text( profileVM.visitedProfile!.partnerBirthdayWeek )
                                    .foregroundColor(.accentColor)
                                    .font(.custom("Avenir", size: 12))
                            }
                        }
                    }.padding(.horizontal)
                    
                    Image("phoneNumberimg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                    
                    VStack {
                        Text( profileVM.visitedProfile!.title )
                            .foregroundColor(.white)
                            .font(.custom("times", size: 24))
                            .fontWeight(.bold)
                            .padding(8)
                        
                        Text( profileVM.visitedProfile!.sln_description)
                            .foregroundColor(.accentColor)
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
                            .foregroundColor(.accentColor)
                        
                        LabelAlignment(text: profileVM.visitedProfile!.report, textAlignmentStyle: .justified, width: UIScreen.main.bounds.width - 30)
                        
                        
                        Text( NSLocalizedString("advice", comment: ""))
                            .font(.custom("times", size: 18))
                            .foregroundColor(.accentColor)
                        
                        Text( profileVM.visitedProfile!.advice )
                            .foregroundColor(.white)
                            .font(.custom("times", size: 16))
                            .multilineTextAlignment(.center)
                            .padding(8)
                    }
                    
                    Divider()
                        .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                    
                }.padding(.top, 1)
            }
            
            CustomAlert(isPresented: $profileVM.showAlert, alertMessage: profileVM.alertMessage, alignment: .center)
                .offset(y: profileVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.navigationBarTitle("")
        .navigationBarTitleView(SearchNavBar(title: userName))
        .onAppear {
            profileVM.getVisitedProfile(userID: userID)
        }
    }
}

struct VisitedProfile_Previews: PreviewProvider {
    static var previews: some View {
        VisitedProfile(userID: 1, userName: "John Smith")
    }
}
