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
    @State private var openCountryCodeList: Bool = false
    @State private var animate: Bool = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "us")
        formatter.setLocalizedDateFormatFromTemplate("MMMM dd, yyyy")
        return formatter
    }
    
    var body: some View {
        ZStack {
            Background()
            
            GeometryReader { proxy in
                ScrollView(showsIndicators: false) {
                    
                    VStack( alignment: .leading, spacing: 20) {
                        
                        Text( NSLocalizedString("joinUs", comment: ""))
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
                            }).fullScreenCover(isPresented: $fullscreen, content: {
                                BirthdayPicker(birthdayDate: $authVM.birthdayDate)
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
                                    
                                    HStack {
                                        Text( Credentials.countryCodeList[authVM.signUpCountryCode]! )
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
                                
                                TextField(NSLocalizedString("phoneNumber", comment: ""), text: $authVM.signUpPhoneNumber)
                                    .font(.custom("times", size: 20))
                                    .foregroundColor(.white)
                                    .keyboardType(.phonePad)
                                    .textContentType(.telephoneNumber)
                            }
                            
                            Divider()
                        }
                        
                        HStack {
                            
                            Button {
                                authVM.agreement.toggle()
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .fill(authVM.agreement ? Color.green : Color.white)
                                        .frame(width: 16, height: 16, alignment: .center)
                                        .cornerRadius(5)
                                    
                                    if authVM.agreement {
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 10, height: 10, alignment: .center)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            
                            Link(NSLocalizedString("terms", comment: ""), destination: URL(string: Credentials.terms_of_use)!)
                                .foregroundColor(.blue)
                                .font(.custom("Gilroy-Regular", size: 14))
                            
                            Text( "*Required" )
                                .foregroundColor(.red)
                                .font(.custom("Gilroy-Regular", size: 14))
                            
                        }.scaleEffect(animate ? 1.4 : 1)
                        
                        
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
                                        .foregroundColor(AppColors.accentColor)
                                        .underline(true, color: AppColors.accentColor)
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
                                
                                if authVM.agreement {
                                    authVM.sendVerificationCode()
                                } else {
                                    withAnimation(.easeInOut(duration: 0.7)) {
                                        animate.toggle()
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                        withAnimation(.easeInOut(duration: 0.7)) {
                                            animate.toggle()
                                        }
                                    }
                                }
                            }, label: {
                                Image("proceed")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                            }).disabled(!authVM.isSendVerificationCodeClickable)
                        }
                        
                        HStack {
                            Spacer()
                            VStack(spacing: 5) {
                                
                                Text( NSLocalizedString("rightsReserved", comment: ""))
                                    .foregroundColor(.white)
                                    .font(.custom("Gilroy-Regular", size: 10))
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(5)
                                
                                HStack {
                                    Link(NSLocalizedString("madeByDoejo", comment: ""), destination: URL(string: "https://doejo.com")!)
                                        .foregroundColor(.blue)
                                        .font(.custom("Gilroy-Regular", size: 10))
                                    
                                    Link(NSLocalizedString("privacy", comment: ""), destination: URL(string: Credentials.privacy_policy)!)
                                        .foregroundColor(.blue)
                                        .font(.custom("Gilroy-Regular", size: 10))
                                }
                            }
                            Spacer()
                        }
                        
                    }.padding()
                    .padding(.top, 30)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
            }
            
            CustomAlert(isPresented: $authVM.showAlert, alertMessage: authVM.sendVerificationCodeAlertMessage, alignment: .bottom)
                .offset(y: authVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
            
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(Text( "" ))
            .sheet(isPresented: $openCountryCodeList) {
                CountryCodeSelection(isPresented: $openCountryCodeList, country: $authVM.signUpCountryCode)
            }.gesture(DragGesture().onChanged({ _ in
                UIApplication.shared.endEditing()
            }))
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
