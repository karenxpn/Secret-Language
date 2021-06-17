//
//  LabelAlignment.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 17.06.21.
//

import Foundation
import SwiftUI

struct LabelAlignment: UIViewRepresentable {
    var text: String
    var textAlignmentStyle : TextAlignmentStyle
    var width: CGFloat

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.textAlignment = NSTextAlignment(rawValue: textAlignmentStyle.rawValue)!
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = width
        label.font = UIFont(name: "times", size: 18)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .vertical)

        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
    }
}

enum TextAlignmentStyle : Int{
     case left = 0 ,center = 1 , right = 2 ,justified = 3 ,natural = 4
}
