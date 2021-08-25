//
//  SettingsProfileSingleImage.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.08.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SettingsProfileSingleImage: View {
    
    @State private var openSheet: Bool = false
    let image: String
    
    var body: some View {
        ZStack( alignment: .topTrailing) {

            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(AppColors.accentColor, lineWidth: 2)
                    .frame(width: UIScreen.main.bounds.size.width * 0.4, height: UIScreen.main.bounds.size.height * 0.3)
                
                if image.isEmpty {
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(.accentColor)
                        .frame(width: 25, height: 25)
                }

                if !image.isEmpty {
                    WebImage(url: URL(string: image)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.size.width * 0.4, height: UIScreen.main.bounds.size.height * 0.3)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                }
            }
        }.sheet(isPresented: $openSheet, content: {
            // gallery
        })
    }
}

struct SettingsProfileSingleImage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsProfileSingleImage(image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png")
    }
}
