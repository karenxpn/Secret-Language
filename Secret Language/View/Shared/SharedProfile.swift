//
//  SharedProfile.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 22.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SharedProfile: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var profileVM = ProfileViewModel()
    @State private var actionSheet: Bool = false
    let userID: Int
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Background()
                
                if profileVM.loading {
                    ProgressView()
                } else if profileVM.sharedProfile != nil {
                    ScrollView( showsIndicators: false ) {
                        
                        WebImage(url: URL(string: profileVM.sharedProfile!.image))
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
                        
                        Text( "\(profileVM.sharedProfile!.name), \(profileVM.sharedProfile!.age)" )
                            .foregroundColor(.white)
                            .font(.custom("times", size: 20))
                        
                        Text( "..." )
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.bottom, 8)
                        
                        VStack( alignment: .leading) {
                            Text( profileVM.sharedProfile!.user_birthday )
                                .font(.custom("times", size: 16))
                                .foregroundColor(.white)
                            
                            HStack( spacing: 0) {
                                Text( NSLocalizedString("weekOf", comment: ""))
                                    .foregroundColor(.gray)
                                    .font(.custom("Avenir", size: 12))
                                
                                Text( profileVM.sharedProfile!.user_birthday_name )
                                    .foregroundColor(.accentColor)
                                    .font(.custom("Avenir", size: 12))
                            }
                        }.padding(.horizontal)
                        
                        Image("phoneNumberimg")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                        
                        VStack {
                            Text( profileVM.sharedProfile!.sln )
                                .foregroundColor(.white)
                                .font(.custom("times", size: 24))
                                .fontWeight(.bold)
                                .padding(8)
                            
                            Text( profileVM.sharedProfile!.sln_description)
                                .foregroundColor(.accentColor)
                                .font(.custom("times-italic", size: 18))
                                .multilineTextAlignment(.center)
                                .padding(8)
                            
                            Text( "\(NSLocalizedString("since1701", comment: "")) \(profileVM.sharedProfile!.famous_years)")
                                .foregroundColor(.white)
                                .font(.custom("times", size: 16))
                                .multilineTextAlignment(.center)
                                .padding(8)
                            
                            Text( NSLocalizedString("relationshipPersonality", comment: ""))
                                .font(.custom("times", size: 18))
                                .foregroundColor(.accentColor)
                            
                            LabelAlignment(text: profileVM.sharedProfile!.report, textAlignmentStyle: .justified, width: UIScreen.main.bounds.width - 30)
                            
                            
                            Text( NSLocalizedString("advice", comment: ""))
                                .font(.custom("times", size: 18))
                                .foregroundColor(.accentColor)
                            
                            Text( profileVM.sharedProfile!.advice )
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
                
            }.navigationBarTitle("Shared Profile", displayMode: .inline)
            .onAppear {
                profileVM.getSharedProfile(userID: userID)
            }.navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("close")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .padding([.leading, .top, .bottom])
                
            }))
        }
    }
}

struct SharedProfile_Previews: PreviewProvider {
    static var previews: some View {
        SharedProfile(userID: 1)
    }
}
