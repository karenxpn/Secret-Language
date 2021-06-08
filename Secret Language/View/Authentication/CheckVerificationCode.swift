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
                    authVM.singUpVerificationCode = otp
                    authVM.checkVerificationCode()
                }
                
                Spacer()
                
                NavigationLink( destination: ChooseGender().environmentObject(authVM), isActive: $authVM.navigateToChooseGender, label: {
                    EmptyView()
                })
                
                HStack {
                    Spacer()
                    
                    VStack( spacing: 20) {
                        Button(action: {
                            authVM.checkVerificationCode()
                        }, label: {
                            Text( NSLocalizedString("verify", comment: "") )
                                .foregroundColor(.black)
                                .font(.custom("times", size: 16))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(AppColors.accentColor)
                                .cornerRadius(25)
                        }).disabled(!authVM.isCheckVerificationCodeClickable)
                        
                        Button(action: {
                            authVM.resendSignUpVerificationCode()
                        }, label: {
                            Text( NSLocalizedString("resendCode", comment: ""))
                                .font(.custom("Gilroy-Regular", size: 16))
                                .foregroundColor(.blue)
                                .underline()
                        })
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

struct CheckVerificationCode_Previews: PreviewProvider {
    static var previews: some View {
        CheckVerificationCode()
            .environmentObject(AuthViewModel())
    }
}
