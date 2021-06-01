//
//  ConnectionType.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 01.06.21.
//

import SwiftUI

struct ConnectionType: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    var body: some View {
        
        ZStack {
            Background()
            
            if authVM.loadingConnectionsType {
                ProgressView()
            } else {
                VStack( alignment: .leading, spacing: 20 ) {
                    Text(NSLocalizedString("lookingConnections", comment: ""))
                        .foregroundColor(.white)
                        .font(.custom("times", size: 26))
                        .padding(.bottom)

                    Text( NSLocalizedString("chooseModel", comment: ""))
                        .foregroundColor(.accentColor)
                        .font(.custom("Gilroy-Regular", size: 14))
                    
                    
                    SingleConnectionType(type: "Romance", description: "Find that spark in an emprowered community")
                        .environmentObject(authVM)
                    
                    SingleConnectionType(type: "Networking", description: "Make new friends at every stage of your life")
                        .environmentObject(authVM)
                    
                    SingleConnectionType(type: "Business", description: "Move your career forward the modern way")
                        .environmentObject(authVM)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image("proceed")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                        }).disabled(authVM.connectionType.isEmpty)
                    }
                    
                }.padding()
            }
        }
    }
}

struct ConnectionType_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionType()
            .environmentObject(AuthViewModel())
    }
}
