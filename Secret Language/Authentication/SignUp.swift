//
//  SignUp.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI

struct SignUp: View {
    @ObservedObject var authVM = AuthViewModel()
    @State private var fullscreen: Bool = false
    
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
                
                                
                
                VStack( alignment: .leading) {
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
                    
                    TextField(NSLocalizedString("phoneNumber", comment: ""), text: $authVM.signUpPhoneNumber)
                    .font(.custom("times", size: 20))
                    .foregroundColor(.white)
                    .keyboardType(.phonePad)
                    
                    Divider()
                }
                
                Spacer()
                
                HStack {
                    VStack( alignment: .leading) {
                        Text( NSLocalizedString("alreadyHaveAccount", comment: ""))
                            .foregroundColor(.white)
                            .font(.custom("Gilroy-Regular", size: 14))
                        
                        // sign in
                        NavigationLink(
                            destination: SignIn(),
                            label: {
                                Text( NSLocalizedString("signin", comment: "") )
                                    .font(.custom("Gilroy-Regular", size: 14))
                                    .foregroundColor(.accentColor)
                                    .underline(true, color: .accentColor)
                                    .padding(.top, 8)
                            })
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // perform api request for sign up
                    }, label: {
                        Image("proceed")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    })
                }
                
                // proceed
                
            }.padding()
            .padding(.top, 30)
        }.navigationBarHidden(true)
        .fullScreenCover(isPresented: $fullscreen, content: {
            BirthdayPicker()
                .environmentObject(authVM)
        }).onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
