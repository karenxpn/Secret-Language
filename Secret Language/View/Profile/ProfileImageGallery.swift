//
//  ProfileImageGallery.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.08.21.
//

import SwiftUI

struct ProfileImageGallery: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        ZStack {
            Background()
            
            if profileVM.loadingImages {
                ProgressView()
            } else {
                ScrollView {
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

                    LazyVGrid(columns: columns, content: {
                        ForEach( 0..<profileVM.profileImages.count) { index in
                            ProfileImageGallerySingleItem(item: profileVM.profileImages[index])
                                .environmentObject(profileVM)
                        }
                    }).padding(.bottom)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image("proceed")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                        })
                    }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                    
                }.padding(.top, 1)
            }
            
            CustomAlert(isPresented: $profileVM.showProfileImagesAlert, alertMessage: profileVM.profileImagesAlertMessage, alignment: .center)
                .offset(y: profileVM.showProfileImagesAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.onAppear {
            profileVM.getProfileImages()
        }
    }
}

struct ProfileImageGallery_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageGallery()
    }
}
