//
//  SignInCheckVerificationCode.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 03.06.21.
//

import SwiftUI

struct SignInCheckVerificationCode: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @State private var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
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
                    UIApplication.shared.endEditing()
                    authVM.signInVerificationCode = otp
                    authVM.checkSignInVerificationCode()
                    // do smth with otp
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack( spacing: 20) {
                        Button(action: {
                            authVM.checkSignInVerificationCode()
                        }, label: {
                            Text( NSLocalizedString("verify", comment: "") )
                                .foregroundColor(.black)
                                .font(.custom("times", size: 16))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(AppColors.accentColor)
                                .cornerRadius(25)
                        }).disabled(!authVM.isCheckVerificationCodeClickable)
                        
                        if timeRemaining != 0 {
                            Text( "\(timeRemaining) \(timeRemaining > 0 ? "seconds" : "second")")
                                .font(.custom("Gilroy-Regular", size: 16))
                                .onReceive(timer) { _ in
                                    if timeRemaining > 0 {
                                        timeRemaining -= 1
                                    }
                                }
                        }
                        
                        Button(action: {
                            withAnimation {
                                self.timeRemaining = 60
                            }
                            authVM.resendSignInVerificationCode()
                        }, label: {
                            Text( NSLocalizedString("resendCode", comment: ""))
                                .font(.custom("Gilroy-Regular", size: 16))
                                .foregroundColor(.blue)
                                .underline()
                        }).disabled(timeRemaining != 0)
                    }
                                        
                    Spacer()
                }                
            }.padding()
            
            CustomAlert(isPresented: $authVM.showCheckVerificationCodeAlert, alertMessage: authVM.checkVerificationCodeAlertMessage, alignment: .bottom)
                .offset(y: authVM.showCheckVerificationCodeAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.navigationBarTitle(Text( "" ), displayMode: .inline)
        .navigationBarTitleView(AuthNavTitle(title: NSLocalizedString("verification", comment: "")), displayMode: .inline)
    }
}

struct SignInCheckVerificationCode_Previews: PreviewProvider {
    static var previews: some View {
        SignInCheckVerificationCode()
            .environmentObject(AuthViewModel())
    }
}
