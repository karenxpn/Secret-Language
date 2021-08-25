//
//  ProfileImageGallerySingleItem.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.08.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileImageGallerySingleItem: View {
    
    @EnvironmentObject var profileVM: ProfileViewModel
    @State private var openSheet: Bool = false
    let item: ProfileGalleryItem
    
    var body: some View {
        ZStack( alignment: .topTrailing) {

            if item.image.isEmpty {
                Button {
                    openSheet.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(AppColors.accentColor, lineWidth: 2)
                            .frame(width: UIScreen.main.bounds.size.width * 0.4,
                                   height: UIScreen.main.bounds.size.height * 0.3)
                        
                        if item.image.isEmpty {
                            Image(systemName: "plus")
                                .resizable()
                                .foregroundColor(.accentColor)
                                .frame(width: 25, height: 25)
                        }
                    }
                }
            } else {
                Menu {
                    
                    Button {
                        profileVM.removeProfileImage(id: item.id)
                    } label: {
                        Text( NSLocalizedString("removeImage", comment: "") )
                    }
                    
                    Button {
                        
                    } label: {
                        Text( NSLocalizedString("makeProfileImage", comment: ""))
                    }


                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(AppColors.accentColor, lineWidth: 2)
                            .frame(width: UIScreen.main.bounds.size.width * 0.4,
                                   height: UIScreen.main.bounds.size.height * 0.3)
                        
                        if item.image.isEmpty {
                            Image(systemName: "plus")
                                .resizable()
                                .foregroundColor(.accentColor)
                                .frame(width: 25, height: 25)
                        }

                        WebImage(url: URL(string: item.image)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.size.width * 0.4, height: UIScreen.main.bounds.size.height * 0.3)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                    }
                }
            }
            


        }.sheet(isPresented: $openSheet, content: {
            ProfileImagePicker()
                .environmentObject(profileVM)
        })
        
    }
}

struct ProfileImageGallerySingleItem_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageGallerySingleItem(item: ProfileGalleryItem(id: 1, image: ""))
            .environmentObject(ProfileViewModel())
    }
}
