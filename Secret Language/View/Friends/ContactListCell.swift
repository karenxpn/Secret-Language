//
//  ContactListCell.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 23.06.21.
//

import SwiftUI

struct ContactListCell: View {
    
    @EnvironmentObject var friendsVM: FriendsViewModel
    let contact: ContactResponseModel
    
    var body: some View {
        HStack {
            
            Image(uiImage: getImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            
            VStack( alignment: .leading) {
                Text( "\(contact.firstName) \(contact.lastName)")
                    .foregroundColor(.white)
                    .font(.custom("times", size: 18))
                
                Text( contact.phone)
                    .foregroundColor(.gray)
                    .font(.custom("Gilroy-Regualr", size: 15))
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Text(NSLocalizedString("invite", comment: ""))
                    .foregroundColor( .accentColor )
                    .font(.custom("Gilroy-Regular", size: 14))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 18)
                    .background(RoundedRectangle(cornerRadius: 4)
                                    .strokeBorder(AppColors.accentColor, lineWidth: 1.5)
                                    .background(AppColors.dataFilterGendersBg)
                    )
            }
        }.padding(.vertical, 10)
    }
    
    func getImage() -> UIImage {
        if contact.image == nil {
            return UIImage(systemName: "person.crop.circle")!
                .withTintColor(.white, renderingMode: .alwaysTemplate)
        }
        
        return UIImage(data: contact.image!)!
    }
    
}
