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
    @State private var editing: Bool = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var body: some View {
        ZStack {
            Background()
            
            
            VStack( alignment: .leading) {
                                
                if editing {
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            Image("phoneNumberimg")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                            
                            Text( "Secret Language" )
                                .foregroundColor(.white)
                                .font(.custom("times", size: 26))
                                .padding()
                        }
                        
                        Spacer()
                    }

                } else {
                    Text( NSLocalizedString("joinUs", comment: ""))
                        .foregroundColor(.white)
                        .font(.custom("times", size: 26))
                        .padding(.bottom)
                    
                    Text( NSLocalizedString("birthdayToStart", comment: ""))
                        .foregroundColor(.accentColor)
                        .font(.custom("Gilroy-Regular", size: 14))
                }
                
                
                Spacer()
                
                
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
                                
                TextField(NSLocalizedString("phoneNumber", comment: ""), text: $authVM.phoneNumber) { editing in
                    withAnimation {
                        self.editing.toggle()
                    }
                } onCommit: {
                }
                .font(.custom("times", size: 20))
                .foregroundColor(.white)
                .keyboardType(.phonePad)
                
                Divider()
                
                Spacer()
                
                HStack {
                    VStack( alignment: .leading) {
                        Text( NSLocalizedString("alreadyHaveAccount", comment: ""))
                            .foregroundColor(.white)
                            .font(.custom("Gilroy-Regular", size: 14))
                        
                        // sign in
                        NavigationLink(
                            destination: Text("Destination"),
                            label: {
                                Text( NSLocalizedString("signin", comment: "") )
                                    .font(.custom("Gilroy-Regular", size: 14))
                                    .foregroundColor(.accentColor)
                                    .underline(true, color: .accentColor)
                                    .padding(.top, 8)
                            })
                    }
                    
                    Spacer()
                    
                    Button(action: {}, label: {
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
