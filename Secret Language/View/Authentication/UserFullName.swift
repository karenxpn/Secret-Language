//
//  UserFullName.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 09.06.21.
//

import SwiftUI

struct UserFullName: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        
        ZStack {
            Background()
            
            VStack( alignment: .leading) {
                
                Text( NSLocalizedString("pleaseEnterFullName", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                    .padding(.bottom)
                
                Text( NSLocalizedString("fullNameMayHelp", comment: ""))
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
                
                Spacer()
                
                VStack( alignment: .leading) {
                    Text( NSLocalizedString("enterFullName", comment: "") )
                        .foregroundColor(.gray)
                        .font(.custom("Gilroy-Regular", size: 10))
                    
                    TextField(NSLocalizedString("John Smith(min 3 characters)", comment: ""), text: $authVM.signUpFullName)
                        .font(.custom("times", size: 20))
                        .foregroundColor(.white)
                        .textContentType(.name)
                    
                    Divider()
                }
                
                Spacer()
                
                HStack {
                    NavigationLink(destination: ChooseGender().environmentObject(authVM), isActive: $authVM.navigateToChooseGender) {
                        EmptyView()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        UIApplication.shared.endEditing()
                        authVM.navigateToChooseGender.toggle()
                    }, label: {
                        Image("proceed")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    }).disabled(authVM.signUpFullName.count < 3 || authVM.signUpFullName.count >= 20)
                }
                
            }.padding()
        }.navigationBarTitle(Text( "" ), displayMode: .inline)
        .navigationBarTitleView(AuthNavTitle(title: NSLocalizedString("verificatoin", comment: "")))
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct UserFullName_Previews: PreviewProvider {
    static var previews: some View {
        UserFullName()
            .environmentObject(AuthViewModel())
    }
}
