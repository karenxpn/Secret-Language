//
//  MessageMedia.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 03.08.21.
//

import SwiftUI
import SDWebImageSwiftUI
import AVKit

struct MessageMedia: View {
    
    @EnvironmentObject var roomVM: MessageRoomViewModel
    @Environment(\.presentationMode) var presentationMode
    let media: [ContentModel]
    
    var body: some View {
        
        NavigationView {
            Group {
                if media[0].type == "video" {
                    let player = AVPlayer(url:  URL(string: media[0].message)!)
                    VideoPlayer(player: player)
                        .frame(height: 400)
                    
                } else {
                    WebImage(url: URL(string: media[0].message))
                        .placeholder {
                            ProgressView()
                        }.resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }.navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("close")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .padding([.leading, .top, .bottom])
            }))
        }
    }
}
