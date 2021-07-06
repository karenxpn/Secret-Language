//
//  FamousListCell.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FamousListCell: View {
    let famous: FamousModel
    
    var body: some View {
        VStack {
            
            WebImage(url: URL(string: famous.image))
                .placeholder {
                    ProgressView()
                }.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            Text( famous.name )
                .foregroundColor(.white)
                .font(.custom("times", size: 20))
            
            Text( famous.age )
                .foregroundColor(.gray)
                .font(.custom("Avenir", size: 14))
            
            Divider()
            
        }.frame( width: .greedy)
        .padding()
    }
}

struct FamousListCell_Previews: PreviewProvider {
    static var previews: some View {
        FamousListCell(famous: FamousModel(id: 1, name: "Karen Mirakyan", age: "born 83 years ago", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg"))
    }
}
