//
//  ProfileGalleryResponse.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.08.21.
//

import Foundation
import SwiftUI

struct ProfileGalleryResponse: Codable {
    var canAdd: Bool
    var avatar: ProfileGalleryItem
    var images: [ProfileGalleryItem]
}

struct ProfileGalleryItem: Codable, Identifiable {
    var id: Int
    var image: String
}

struct ProfileGalleryItemViewModel: Identifiable {
    var item: ProfileGalleryItem
    var width: CGFloat
    var height: CGFloat
    
    init( item: ProfileGalleryItem, width: CGFloat, height: CGFloat ) {
        self.item = item
        self.width = width
        self.height = height
    }
    
    var id: Int { self.item.id}
    var image: String { self.item.image + "?tr=w-\(self.width),h-\(self.height)" }
}
