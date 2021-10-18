//
//  SignIn.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI

struct SignIn: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var authVM = AuthViewModel()
    
    @State private var hideNavBar: Bool = true
    @State private var hideBackButton: Bool = false
    @State private var openCountryCodeList: Bool = false
    
    
    var body: some View {
        ZStack( alignment: .leading) {
            Background()
            
            GeometryReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack( alignment: .leading, spacing: 20) {
                        Text( NSLocalizedString("welcomeBack", comment: ""))
                            .foregroundColor(.white)
                            .font(.custom("times", size: 26))
                            .padding(.bottom)
                        
                        Text( NSLocalizedString("birthdayToStart", comment: ""))
                            .foregroundColor(AppColors.accentColor)
                            .font(.custom("Gilroy-Regular", size: 14))
                        
                        HStack {
                            Spacer()
                            
                            Image("phoneNumberimg")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                            
                            Spacer()
                        }.padding(.bottom, 20)
                        
                        
                        VStack( alignment: .leading) {
                            Text( NSLocalizedString("phoneNumber", comment: "") )
                                .foregroundColor(.gray)
                                .font(.custom("Gilroy-Regular", size: 10))
                            
                            HStack {
                                Button {
                                    openCountryCodeList.toggle()
                                } label: {
                                    
                                    HStack {
                                        Text( Credentials.countryCodeList[authVM.signInCountryCode]! )
                                            .font(.custom("times", size: 20))
                                            .foregroundColor(.white)
                                        
                                        Image("openCountryListArrow")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .rotationEffect(.degrees(270))
                                            .frame(width: 10, height: 10)
                                            .foregroundColor(.white)
                                        
                                    }.padding(.horizontal, 6)
                                        .padding(.vertical, 3).overlay(RoundedRectangle(cornerRadius: 10).stroke(AppColors.accentColor, lineWidth: 2))
                                }
                                
                                TextField(NSLocalizedString("phoneNumber", comment: ""), text: $authVM.signInPhoneNumber)
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
                                Text( NSLocalizedString("dontHaveAccount", comment: ""))
                                    .foregroundColor(.white)
                                    .font(.custom("Gilroy-Regular", size: 14))
                                
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Text( NSLocalizedString("signUp", comment: "") )
                                        .font(.custom("Gilroy-Regular", size: 14))
                                        .foregroundColor(AppColors.accentColor)
                                        .underline(true, color: AppColors.accentColor)
                                        .padding(.top, 8)
                                }
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: SignInCheckVerificationCode(hideNavBar: $hideNavBar, hideBackButton: $hideBackButton).environmentObject(authVM), isActive: $authVM.navigateToSignInVerificationCode) {
                                EmptyView()
                            }.hidden()
                            
                            Button(action: {
                                UIApplication.shared.endEditing()
                                authVM.sendSignInVerificationCode()
                            }, label: {
                                Image("proceed")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                            }).disabled(!authVM.isSignInProceedClickable)
                        }
                        
                        AllRightsReservedMadeByDoejo()
                        
                    }.padding()
                    .padding(.top, 30)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
            }
            
            CustomAlert(isPresented: $authVM.showAlert, alertMessage: authVM.sendVerificationCodeAlertMessage, alignment: .bottom)
                .offset(y: authVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.onAppear(perform: {
            hideNavBar = true
            hideBackButton = true
        }).navigationBarTitle("")
            .navigationBarHidden(hideNavBar)
            .navigationBarBackButtonHidden(hideBackButton)
            .gesture(DragGesture().onChanged({ _ in
                UIApplication.shared.endEditing()
            })).sheet(isPresented: $openCountryCodeList) {
                CountryCodeSelection(isPresented: $openCountryCodeList, country: $authVM.signInCountryCode)
            }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
