//
//  CheckVerificationCode.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI

struct CheckVerificationCode: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        ZStack {
            Background()
            
            VStack ( alignment: .leading, spacing: 20) {
                Text( NSLocalizedString("verificationCode", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                
                Text( NSLocalizedString("verificationCodeSent", comment: ""))
                    .foregroundColor(.accentColor)
                    .font(.custom("times", size: 15))
                
                Spacer()
                
                
                OTPTextFieldView { otp, completionHandler in
                    
                    print(otp)
                    // do smth with otp
                }
                
                Spacer()
                
                Button(action: {
                    authVM.checkVerificationCode()
                }, label: {
                    Text( NSLocalizedString("verify", comment: "") )
                        .foregroundColor(.black)
                        .font(.custom("times", size: 16))
                        .frame(width: UIScreen.main.bounds.size.width * 0.8)
                        .padding()
                        .background(AppColors.accentColor)
                        .cornerRadius(25)
                })
                
                HStack {
                    Spacer()
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text( NSLocalizedString("resendCode", comment: ""))
                            .font(.custom("Gilroy-Regular", size: 16))
                            .foregroundColor(.blue)
                            .underline()
                        
                    })
                    Spacer()
                }
                
                
            }.padding()
            
            CustomAlert(isPresented: $authVM.showAlert, alertMessage: authVM.checkVerificationCodeAlertMessage, alignment: .bottom)
                .offset(y: authVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.navigationBarTitle(Text( NSLocalizedString("verification", comment: "") ), displayMode: .inline)
        .onAppear(perform: {
            
        })
    }
}

struct CheckVerificationCode_Previews: PreviewProvider {
    static var previews: some View {
        CheckVerificationCode()
            .environmentObject(AuthViewModel())
    }
}
