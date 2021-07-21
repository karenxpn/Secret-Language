//
//  MessageImageHelper.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 22.07.21.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct MessageImageHelper: View {
    let image: String
    let progressViewTintColor: Color
    
    var body: some View {
        WebImage(url: URL(string: image))
            .placeholder(content: {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: progressViewTintColor))
            })
            .resizable()
            .scaledToFill()
    }
}
