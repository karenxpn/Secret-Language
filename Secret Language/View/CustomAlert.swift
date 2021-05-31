//
//  CustomAlert.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI

struct CustomAlert: View {
    
    @Binding var isPresented: Bool
    let alertMessage: String
    let alignment: Alignment
    
    var body: some View {
        GeometryReader { proxy in
            VStack( alignment: .leading, spacing: 10) {
                
                Text( NSLocalizedString("alert", comment: ""))
                    .font(.custom("Gilroy-Regular", size: 20))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Text( alertMessage )
                    .foregroundColor(.gray)
                    .font(.custom("Gilroy-Regular", size: 14))
                    .padding(.bottom, 20)
                
                Button(action: {
                    isPresented.toggle()
                }, label: {
                    Text( NSLocalizedString("gotIt", comment: ""))
                        .font(.custom("Gilroy-Regular", size: 18))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.size.width - 24, height: 50)
                        .background(AppColors.accentColor)
                        .cornerRadius(10)
                }).padding(.bottom, 30)
                
            }.padding()
            .background(AppColors.blueColor)
            .cornerRadius(25)
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: alignment)
        }.background(Color.gray.opacity( 0.75 ))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Alert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(isPresented: .constant( false ), alertMessage: "Attention, username or password is not valid !", alignment: .bottom)
    }
}
