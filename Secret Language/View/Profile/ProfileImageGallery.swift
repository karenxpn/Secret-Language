//
//  ProfileImageGallery.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.08.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileImageGallery: View {
    
    @ObservedObject var profileVM = ProfileViewModel()
    @Binding var isPresented: Bool
    @State private var openSheet: Bool = false
    
    var body: some View {
        ZStack {
            Background()
            
            if profileVM.loadingImages {
                ProgressView()
            } else if profileVM.profileImages != nil {
                ScrollView( showsIndicators: false ) {
                    
                    ImageHelper(image: profileVM.profileImages!.avatar.image, contentMode: .fill, progressViewTintColor: .white)
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.5)
                        .clipped()
                    
                    Text( NSLocalizedString("myPhotos", comment: ""))
                        .foregroundColor( .white )
                        .font(.custom("Gilroy-Regular", size: 15))
                        .fontWeight(.bold)
                        .padding()
                    
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
                    
                    LazyVGrid(columns: columns, spacing: 20, content: {
                        
                        if profileVM.profileImages!.canAdd {
                            Button {
                                openSheet.toggle()
                            } label: {
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(AppColors.reportBoxesBG)
                                        .frame(width: UIScreen.main.bounds.size.width * 0.45, height: UIScreen.main.bounds.size.height * 0.3)
                                    
                                    Image("plus")
                                }
                            }
                        }
                        
                        ForEach( 0..<profileVM.profileImages!.images.count) { index in
                            ProfileImageGallerySingleItem(item: profileVM.profileImages!.images[index])
                                .environmentObject(profileVM)
                        }
                    }).padding(.bottom)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            isPresented.toggle()
                        }, label: {
                            Image("proceed")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                        })
                    }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                    
                }.edgesIgnoringSafeArea([.top, .bottom])
            }
            
            CustomAlert(isPresented: $profileVM.showAlert, alertMessage: profileVM.alertMessage, alignment: .center)
                .offset(y: profileVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.onAppear {
            profileVM.getProfileImages()
        }.navigationBarTitle("")
        .navigationBarTitleView(FriendsNavBar(title: ""), displayMode: .inline)
        .sheet(isPresented: $openSheet, content: {
            ProfileImagePicker()
                .environmentObject(profileVM)
        })
    }
}

struct ProfileImageGallery_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageGallery(isPresented: .constant(false))
    }
}
