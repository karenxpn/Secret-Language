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
            
            if authVM.loadingConnectionTypes {
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
                    
                    ForEach( authVM.connectionTypes, id: \.id ) { connection in
                        SingleConnectionType(connection: connection)
                            .environmentObject(authVM)
                    }
                    
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
        }.onAppear {
            authVM.getConnectionTypes()
        }
    }
}

struct ConnectionType_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionType()
            .environmentObject(AuthViewModel())
    }
}
