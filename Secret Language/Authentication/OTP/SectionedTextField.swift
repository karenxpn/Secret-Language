//
//  SectionedTextField.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 01.06.21.
//

import SwiftUI

struct SectionedTextField: View {
    @State private var numberOfCells: Int = 6
    @State private var currentlySelectedCell = 0
    
    var body: some View {
        HStack {
            ForEach(0 ..< self.numberOfCells) { index in
                CharacterInputCell(currentlySelectedCell: self.$currentlySelectedCell, index: index)
            }
        }
    }
}

struct SectionedTextField_Previews: PreviewProvider {
    static var previews: some View {
        SectionedTextField()
    }
}


struct CharacterInputCell: View {
    @State private var textValue: String = ""
    @Binding var currentlySelectedCell: Int
    
    var index: Int
    
    var responder: Bool {
        return index == currentlySelectedCell
    }
    
    var body: some View {
        CustomTextField(text: $textValue, currentlySelectedCell: $currentlySelectedCell, isFirstResponder: responder)
            .frame(height: 20)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding([.trailing, .leading], 10)
            .padding([.vertical], 15)
            .lineLimit(1)
            .multilineTextAlignment(.center)
            .background(RoundedRectangle(cornerRadius: 6)
                            .fill(AppColors.boxColor))
        
    }
}
