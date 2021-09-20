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
                        .foregroundColor(AppColors.accentColor)
                        .font(.custom("Gilroy-Regular", size: 14))
                    
                    ForEach( authVM.connectionTypes, id: \.id ) { connection in
                        SingleConnectionType(connection: connection)
                            .environmentObject(authVM)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink( destination: GenderPreference().environmentObject(authVM), label: {
                            Image("proceed")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                        }).disabled(authVM.connectionType == nil)
                    }
                    
                }.padding()
            }
            
            CustomAlert(isPresented: $authVM.showSignUpAlert, alertMessage: authVM.signUpAlertMessage, alignment: .bottom)
                .offset(y: authVM.showSignUpAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.navigationBarTitle(Text( "" ), displayMode: .inline)
        .navigationBarTitleView(AuthNavTitle(title: NSLocalizedString("lookingFor", comment: "")), displayMode: .inline)
        .onAppear {
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
