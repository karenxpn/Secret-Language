//
//  PendingListCell.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 23.06.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PendingListCell: View {
    
    @EnvironmentObject var friendsVM: FriendsViewModel
    let pendingRequest: UserPreviewModel
    
    var body: some View {
        
        HStack( spacing: 20) {
            WebImage(url: URL(string: pendingRequest.image))
                .placeholder {
                    ProgressView()
                }.resizable()
                .scaledToFill()
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            
            VStack( alignment: .leading) {
                Text( pendingRequest.name )
                    .foregroundColor(.white)
                    .font(.custom("times", size: 18))
                
                HStack( spacing: 0) {
                    Text( "\(NSLocalizedString("idealFor", comment: ""))")
                        .foregroundColor(.gray)
                        .font(.custom("Gilroy-Regular", size: 15))
                    
                    Text( pendingRequest.ideal_for)
                        .foregroundColor(.accentColor)
                        .font(.custom("Gilroy-Regular", size: 15))
                }
            }
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Text(NSLocalizedString("pending", comment: ""))
                    .foregroundColor( .accentColor )
                    .font(.custom("Gilroy-Regular", size: 14))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 18)
                    .background(RoundedRectangle(cornerRadius: 4)
                                    .strokeBorder(AppColors.accentColor, lineWidth: 1.5)
                                    .background(AppColors.dataFilterGendersBg)
                )
            })
        }.padding()
    }
}

struct PendingListCell_Previews: PreviewProvider {
    static var previews: some View {
        PendingListCell(pendingRequest: UserPreviewModel(id: 1, name: "John Smith", image: "", ideal_for: "Business"))
    }
}
