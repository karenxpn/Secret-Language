//
//  SignUp.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI

struct SignUp: View {
    @StateObject var authVM = AuthViewModel()
    @State private var fullscreen: Bool = false
    @State private var login: Bool = false
    @State private var openCountryCodeList: Bool = false
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var body: some View {
        ZStack {
            Background()
            
            VStack( alignment: .leading, spacing: 20) {
                
                Text( NSLocalizedString("joinUs", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                    .padding(.bottom)
                
                Text( NSLocalizedString("birthdayToStart", comment: ""))
                    .foregroundColor(.accentColor)
                    .font(.custom("Gilroy-Regular", size: 14))
                
                HStack {
                    Spacer()
                    
                    Image("phoneNumberimg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                    
                    Spacer()
                }.padding(.bottom, 20)
                
                VStack( alignment: .leading ) {
                    Text( NSLocalizedString("birthday", comment: "") )
                        .foregroundColor(.gray)
                        .font(.custom("Gilroy-Regular", size: 10))
                    
                    Button(action: {
                        fullscreen.toggle()
                    }, label: {
                        Text( dateFormatter.string(from: authVM.birthdayDate))
                            .foregroundColor(.white)
                            .font(.custom("times", size: 20))
                    })
                    Divider()
                        .padding(.bottom)
                }
                
                VStack( alignment: .leading) {
                    Text( NSLocalizedString("phoneNumber", comment: "") )
                        .foregroundColor(.gray)
                        .font(.custom("Gilroy-Regular", size: 10))
                    
                    HStack {
                        Button {
                            openCountryCodeList.toggle()
                        } label: {
                            Text( Credentials.countryCodeList[authVM.signUpCountryCode]! )
                                .font(.custom("times", size: 20))
                                .foregroundColor(.white)
                        }
                        
                        TextField(NSLocalizedString("phoneNumber", comment: ""), text: $authVM.signUpPhoneNumber)
                            .font(.custom("times", size: 20))
                            .foregroundColor(.white)
                            .keyboardType(.phonePad)
                            .textContentType(.telephoneNumber)
                    }
                    
                    Divider()
                }
                
                Spacer()
                
                HStack {
                    VStack( alignment: .leading) {
                        Text( NSLocalizedString("alreadyHaveAccount", comment: ""))
                            .foregroundColor(.white)
                            .font(.custom("Gilroy-Regular", size: 14))
                        
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                        
                        NavigationLink( destination: SignIn(), label: {
                            Text( NSLocalizedString("signin", comment: "") )
                                .font(.custom("Gilroy-Regular", size: 14))
                                .foregroundColor(.accentColor)
                                .underline(true, color: .accentColor)
                                .padding(.top, 8)
                        })
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: CheckVerificationCode()
                                    .environmentObject(authVM),
                                   isActive: $authVM.navigateToCheckVerificationCode) {
                        EmptyView()
                    }.hidden()
                    
                    Button(action: {
                        UIApplication.shared.endEditing()
                        authVM.sendVerificationCode()
                    }, label: {
                        Image("proceed")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    }).disabled(!authVM.isSendVerificationCodeClickable)
                }
                
            }.padding()
            .padding(.top, 30)
            
            CustomAlert(isPresented: $authVM.showAlert, alertMessage: authVM.sendVerificationCodeAlertMessage, alignment: .bottom)
                .offset(y: authVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text( "" ))
        .fullScreenCover(isPresented: $fullscreen, content: {
            BirthdayPicker(birthdayDate: $authVM.birthdayDate)
        }).onTapGesture {
            UIApplication.shared.endEditing()
        }.sheet(isPresented: $openCountryCodeList) {
            CountryCodeSelection(isPresented: $openCountryCodeList, country: $authVM.signUpCountryCode)
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
