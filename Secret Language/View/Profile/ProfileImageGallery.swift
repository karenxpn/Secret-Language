//
//  ProfileImageGallery.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.08.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileImageGallery: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var profileVM: ProfileViewModel
    @State private var openSheet: Bool = false
    
    var body: some View {
        ZStack {
            Background()
            
            if profileVM.loadingImages {
                ProgressView()
            } else if profileVM.profileImages != nil {
                ScrollView {
                    
                    WebImage(url: URL(string: profileVM.profileImages!.avatar.image))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.4)
                    
                    Text( "My Photos" )
                        .foregroundColor( .white )
                        .font(.custom("Gilroy-Regular", size: 15))
                        .fontWeight(.bold)
                    
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
                    
                    LazyVGrid(columns: columns, content: {
                        
                        Button {
                            openSheet.toggle()
                        } label: {
                            Image("addImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.size.width * 0.35, height: UIScreen.main.bounds.size.height * 0.25)
                        }
                        
                        ForEach( 0..<profileVM.profileImages!.images.count) { index in
                            ProfileImageGallerySingleItem(item: profileVM.profileImages!.images[index])
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
                    
                }.edgesIgnoringSafeArea([.top, .bottom])
            }
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
        ProfileImageGallery()
    }
}
