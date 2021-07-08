//
//  SWViewHelper.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 07.07.21.
//

import SwiftUI

struct SWViewHelper: View {
    let s1: String
    let s2: String
    let s3: String
    let w1: String
    let w2: String
    let w3: String
    var body: some View {
        HStack {
            
            VStack( alignment: .leading) {
                Text( s1 )
                    .foregroundColor(.black)
                    .font(.custom("times", size: 14))
                
                Text( s2 )
                    .foregroundColor(.black)
                    .font(.custom("times", size: 14))
                
                Text( s3 )
                    .foregroundColor(.black)
                    .font(.custom("times", size: 14))
            }
            
            Spacer()
            
            VStack( alignment: .trailing) {
                Text( w1 )
                    .foregroundColor(.black)
                    .font(.custom("times", size: 14))
                
                Text( w2 )
                    .foregroundColor(.black)
                    .font(.custom("times", size: 14))
                
                Text( w3 )
                    .foregroundColor(.black)
                    .font(.custom("times", size: 14))
            }
        }
    }
}

struct SWViewHelper_Previews: PreviewProvider {
    static var previews: some View {
        SWViewHelper(s1: "Tasteful", s2: "Caring", s3: "Powerful", w1: "Profligate", w2: "Self-Indulgent", w3: "Over-Protective")
    }
}
