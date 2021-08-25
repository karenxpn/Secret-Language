//
//  ProfileGalleryResponse.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.08.21.
//

import Foundation
struct ProfileGalleryResponse: Codable {
    var avatar: ProfileGalleryItem
    var images: [ProfileGalleryItem]
}

struct ProfileGalleryItem: Codable, Identifiable {
    var id: Int
    var image: String
}
