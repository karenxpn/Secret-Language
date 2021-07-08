//
//  ImageHelper.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 07.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageHelper: View {
    
    let image: String
    let contentMode: ContentMode
    let progressViewTintColor: Color
    
    var body: some View {
        WebImage(url: URL(string: image))
                    .placeholder(content: {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: progressViewTintColor))
                    })
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
    }
}
