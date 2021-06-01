//
//  SingleConnectionType.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 01.06.21.
//

import SwiftUI

struct SingleConnectionType: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    let type: String
    let description: String
    
    var body: some View {
        
        Button(action: {
            authVM.connectionType = type
        }, label: {
            VStack {
                Text( type )
                    .foregroundColor(authVM.connectionType == type ? .black : .white)
                    .font(.custom("times", size: 16))
                
                Text( description )
                    .foregroundColor(Color(UIColor(red: 55/255, green: 66/255, blue: 77/255, alpha: 1)))
                    .font(.custom("Avenir", size: 10))
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(authVM.connectionType == type ? .accentColor : AppColors.boxColor)
            .cornerRadius(15)
        })
    }
}

struct SingleConnectionType_Previews: PreviewProvider {
    static var previews: some View {
        SingleConnectionType(type: "Romance", description: "Find that spark in an emprowered community")
            .environmentObject(AuthViewModel())
    }
}
