//
//  Extensions.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
