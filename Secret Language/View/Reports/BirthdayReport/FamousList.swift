//
//  FamousList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI

struct FamousList: View {
    let famousList: [FamousModel]
    
    var body: some View {
        LazyVStack {
            ForEach( famousList, id: \.id ) { famous in
                FamousListCell(famous: famous)
            }
        }
    }
}

struct FamousList_Previews: PreviewProvider {
    static var previews: some View {
        FamousList(famousList: [FamousModel(id: 1, name: "Karen Mirakyan", age: "born 83 years ago", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg", sln: "")])
    }
}
