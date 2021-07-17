//
//  RoomImageMessagesHelper.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 17.07.21.
//

import SwiftUI

import SwiftUI
import SDWebImageSwiftUI

struct RoomImageMessagesHelper: View {
    let image: String
    var body: some View {
        WebImage(url: URL(string: image))
            .placeholder(content: {
                ProgressView()
            })
            .resizable()
            .scaledToFill()
    }
}

struct RoomImageMessagesHelper_Previews: PreviewProvider {
    static var previews: some View {
        RoomImageMessagesHelper(image: "")
    }
}
