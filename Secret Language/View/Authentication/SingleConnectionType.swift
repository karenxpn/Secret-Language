//
//  SingleConnectionType.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 01.06.21.
//

import SwiftUI

struct SingleConnectionType: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    let connection: ConnectionTypeModel
    
    var body: some View {
        
        Button(action: {
            authVM.connectionType = connection.id
        }, label: {
            VStack {
                Text( connection.name )
                    .foregroundColor(authVM.connectionType == connection.id ? .black : .white)
                    .font(.custom("times", size: 16))
                
                Text( connection.description )
                    .foregroundColor(Color(UIColor(red: 55/255, green: 66/255, blue: 77/255, alpha: 1)))
                    .font(.custom("Avenir", size: 10))
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(authVM.connectionType == connection.id ? .accentColor : AppColors.boxColor)
            .cornerRadius(15)
        })
    }
}

struct SingleConnectionType_Previews: PreviewProvider {
    static var previews: some View {
        SingleConnectionType(connection: ConnectionTypeModel(id: 1, name: "type", description: "desctiprion"))
            .environmentObject(AuthViewModel())
    }
}
