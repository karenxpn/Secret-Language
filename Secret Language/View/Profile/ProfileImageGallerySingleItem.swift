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
            ImageHelper(image: item.image, contentMode: .fill, progressViewTintColor: .white)
                .frame(width: UIScreen.main.bounds.size.width * 0.45,
                       height: UIScreen.main.bounds.size.height * 0.3)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                    
        }
    }
}

struct ProfileImageGallerySingleItem_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageGallerySingleItem(item: ProfileGalleryItem(id: 1, image: ""))
            .environmentObject(ProfileViewModel())
    }
}
