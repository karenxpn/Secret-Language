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
    let item: ProfileGalleryItem
    
    var body: some View {
        Menu {
            
            Button {
                profileVM.removeProfileImage(id: item.id)
            } label: {
                Text( NSLocalizedString("removeImage", comment: "") )
            }
            
            Button {
                profileVM.makeProfileImage(id: item.id)
            } label: {
                Text( NSLocalizedString("makeProfileImage", comment: ""))
            }
            
        } label: {
//            ZStack {
//                RoundedRectangle(cornerRadius: 15)
//                    .stroke(AppColors.accentColor, lineWidth: 2)
//                    .frame(width: UIScreen.main.bounds.size.width * 0.35, height: UIScreen.main.bounds.size.height * 0.25)
//
                WebImage(url: URL(string: item.image)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.size.width * 0.35, height: UIScreen.main.bounds.size.height * 0.25)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
//            }
        }
    }
}

struct ProfileImageGallerySingleItem_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageGallerySingleItem(item: ProfileGalleryItem(id: 1, image: ""))
            .environmentObject(ProfileViewModel())
    }
}
