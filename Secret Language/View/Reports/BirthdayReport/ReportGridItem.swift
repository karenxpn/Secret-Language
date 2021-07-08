//
//  ReportGridItem.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 08.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReportGridItem: View {
    
    let title: String
    let image: String
    let name: String
    let destination: AnyView
    
    var body: some View {
        VStack( spacing: 10 ) {
            Text( title )
                .foregroundColor(.white)
                .font(.custom("AppleMyungjo", size: 15))
                .multilineTextAlignment(.center)
            
            ZStack {
                Color.white
                    .cornerRadius(5)
                    .padding(.horizontal)
                    .frame(height: 135)
                
                ImageHelper(image: image, contentMode: .fit, progressViewTintColor: .white)
                    .frame(width: UIScreen.main.bounds.size.width * 0.45, height: 100)
                    .cornerRadius(5)
            }

            
            Text( name )
                .foregroundColor(.white)
                .font(.custom("times-italic", size: 12))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            NavigationLink( destination: destination, label: {
                Text( NSLocalizedString("readReport", comment: "") )
                    .font(.custom("times", size: 16))
                    .foregroundColor(AppColors.accentColor)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 18)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .strokeBorder( AppColors.accentColor, lineWidth: 1)
                    )
            })
            
        }.frame(width: UIScreen.main.bounds.size.width * 0.45)
        .padding(.vertical)
        .background(AppColors.boxColor)
        .cornerRadius(12)
    }
}

struct ReportGridItem_Previews: PreviewProvider {
    static var previews: some View {
        ReportGridItem(title: "Jun 19-24", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png", name: "The day of the symbolic herald", destination: AnyView(EmptyView()))
    }
}
