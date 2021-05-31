//
//  CheckVerificationCode.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI

struct CheckVerificationCode: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        ZStack {
            Background()
            
            CustomAlert(isPresented: $authVM.showAlert, alertMessage: authVM.checkVerificationCodeAlertMessage, alignment: .bottom)
                .offset(y: authVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
        }
    }
}

struct CheckVerificationCode_Previews: PreviewProvider {
    static var previews: some View {
        CheckVerificationCode()
    }
}
